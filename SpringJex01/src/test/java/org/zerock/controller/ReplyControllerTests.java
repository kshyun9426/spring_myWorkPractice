package org.zerock.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //Servlet의 ServletContext를 이용하기 위해서사용, 스프링에서는 WebApplicationContext라는 존재를 이용하기 위해서
@ContextConfiguration(classes= {org.zerock.config.RootConfig.class, org.zerock.config.ServletConfig.class})
@Log4j
public class ReplyControllerTests {
	
	@Setter(onMethod_= {@Autowired})
	private ReplyService replyService;
	
	@Setter(onMethod_= {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testNewReply() throws Exception {
		
		ReplyVO vo = new ReplyVO();
		vo.setBno(36L);
		vo.setReply("Hello Reply3");
		vo.setReplyer("ksh3");
		
		String jsonStr = new Gson().toJson(vo);
		
		log.info(jsonStr);
		
		mockMvc.perform(MockMvcRequestBuilders.post("/replies/new")
				.contentType(MediaType.APPLICATION_JSON)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
}




















