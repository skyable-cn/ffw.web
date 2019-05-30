package com.ffw.web.controller;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.Pinyin;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("domain")
public class DomainController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(DomainController.class);

	@Autowired
	RestTemplateUtil rest;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		pd.put("CDT", DateUtil.getTime());
		
		PageData pdu = new PageData();
		String pinYinName = Pinyin.getPinYinHeadChar(pd
				.getString("DOMAINNAME"));
		String pinYinNameTemp = Pinyin.getPinYinHeadChar(pd
				.getString("DOMAINNAME"));
		int nameOrder = 1;
		while (true) {
			pdu.put("USERNAME", pinYinNameTemp);
			PageData user = rest.post(IConstant.FFW_SERVICE_KEY,
					"user/findByName", pdu, PageData.class);
			if (null == user) {
				break;
			}
			pinYinNameTemp = (pinYinName + nameOrder);
			nameOrder++;
		}
		
		pd.put("ACCOUNTER", pinYinNameTemp);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "domain/save", pd, PageData.class);
		
		
		
		
		pdu.put("PASSWORD",
				new SimpleHash("SHA-1", pdu.getString("USERNAME"),
						IConstant.DEFAULT_PASSWORD).toString()); // 密码加密
		pdu.put("DM_ID", pd.getString("DOMAIN_ID"));
		pdu.put("ROLE_ID", IConstant.STRING_2);
		pdu.put("CDT", DateUtil.getTime());
		pdu.put("STATE", IConstant.STRING_1);
		rest.post(IConstant.FFW_SERVICE_KEY, "user/save", pdu,
				PageData.class);
		

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "区域模块" },
						""));
		mv.setViewName("redirect:/domain/listPage");
		logger.info("新增区域模块成功");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ModelAndView delete(@RequestParam String DOMAIN_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("DOMAIN_ID", DOMAIN_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "domain/delete", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS",
						new Object[] { "区域模块" }, ""));
		mv.setViewName("redirect:/domain/listPage");
		logger.info("删除区域模块成功");

		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		rest.post(IConstant.FFW_SERVICE_KEY, "domain/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS",
						new Object[] { "区域模块" }, ""));
		mv.setViewName("redirect:/domain/listPage");
		logger.info("修改区域模块成功");
		return mv;
	}

	@RequestMapping("listPage")
	public ModelAndView listPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "domain/listPage", pd,
				Page.class);

		mv.setViewName("/domain/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询区域模块信息");
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		mv.addObject("pd", pd);
		mv.setViewName("domain/add");
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "domain/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("domain/edit");
		return mv;
	}
	
	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "domain/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("domain/info");
		return mv;
	}
}
