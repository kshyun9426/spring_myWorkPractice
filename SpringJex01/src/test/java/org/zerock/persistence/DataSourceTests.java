package org.zerock.persistence;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;
import org.zerock.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class DataSourceTests {

	@Setter(onMethod_= {@Autowired})
	private DataSource dataSource;
	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	@Setter(onMethod_= {@Autowired})
	private TimeMapper timeMapper;
	
//	@Test
//	public void testConnection() {
//		try(Connection con = dataSource.getConnection()){
//			assertNotNull(con);
//			log.info(con);
//		}catch(SQLException ex) {
//			fail(ex.getMessage());
//		}
//	}
	
//	@Test
//	public void testMyBatis() {
//		try(SqlSession session = sqlSessionFactory.openSession(); Connection conn = session.getConnection()){
//			log.info(session);
//			log.info(conn);
//		}catch(SQLException ex) {
//			fail(ex.getMessage());
//		}
//	}
	
	@Test
	public void testGetTime2() {
		log.info("GetTime2");
		log.info(timeMapper.getTime2());
	}
}

















