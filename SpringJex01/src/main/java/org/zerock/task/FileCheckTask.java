package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {
	
	/*
	 * To do List
	 *  1.데이터베이스에서 어제 사용된 파일의 목록을 얻어오고
	 *  2.해당 폴더의 파일 목록에서 데이터베이스에 없는 파일을 찾아낸다
	 *  3.이후 데이터베이스에 없는 파일들을 삭제하는 순서로 구성
	 */
	
	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper boardAttachMapper;
	
	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception {
		
		log.warn("=====================File check Task run=====================");
		log.warn(new Date());
		//get yesterdat file list in database 
		List<BoardAttachVO> fileList = boardAttachMapper.getOldFiles();
		
		//ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), vo.getUuid(), "_", vo.getFileName()))
				.collect(Collectors.toList());
		
		//image file has thumbnail file so add thumbnail path on fileListPaths variable
		fileList.stream()
			.filter(vo->vo.isFileType()==true)
			.map(vo->Paths.get("C:\\uploadEx", vo.getUploadPath(), "\\s_", vo.getUuid(), "_", vo.getFileName()))
			.forEach(path->fileListPaths.add(path));
		
		log.warn("=============================================================");
		
		fileListPaths.forEach(path->log.warn(path));
		
		File targetDir = Paths.get("C:\\uploadEx", getFolderYesterday()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file->fileListPaths.contains(file.getPath())==false);
		log.warn("--------------------------------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
	
	private String getFolderYesterday() {
		SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace(str, File.separator);
	}
}




















