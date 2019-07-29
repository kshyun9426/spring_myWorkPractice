package org.zerock.controller;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //Servlet의 ServletContext를 이용하기 위해서사용, 스프링에서는 WebApplicationContext라는 존재를 이용하기 위해서
@ContextConfiguration(classes= {org.zerock.config.RootConfig.class, org.zerock.config.ServletConfig.class})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_= {@Autowired})
	private WebApplicationContext ctx;
	
	//MockMvc클래스로 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다. 
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Test
//	public void testList() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list")) //MockMvcRequestBuilders를 사용해서 get방식 호출
//				.andReturn()
//				.getModelAndView()
//				.getModelMap());
//	}
	
//	@Test
//	public void testRegister() throws Exception {
//		
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
//				.param("title", "테스트 새글 제목")
//				.param("content", "테스트 새글 내용")
//				.param("writer", "user00"))
//				.andReturn().getModelAndView().getViewName();
//		log.info(resultPage);
//		assertEquals("redirect:/board/list", resultPage);
//	}
	
//	@Test
//	public void testGet() throws Exception{
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
//				.param("bno", "2"))
//				.andReturn()
//				.getModelAndView()
//				.getModelMap());
//	}
	
//	@Test
//	public void testModify() throws Exception {
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
//				.param("bno", "9")
//				.param("title", "수정된 테스트 새글 제목")
//				.param("content", "수정된 테스트 새글 내용")
//				.param("writer", "user01"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		log.info(resultPage);
//	}
	
//	@Test
//	public void testRemove() throws Exception {
//		
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
//				.param("bno", "6"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		log.info(resultPage);
//		
//	}
	
	
}




























