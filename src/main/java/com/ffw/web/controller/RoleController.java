package com.ffw.web.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("role")
public class RoleController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(RoleController.class);

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

		pd.put("DELETEFLAG", IConstant.STRING_0);
		rest.post(IConstant.FFW_SERVICE_KEY, "role/save", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "系统角色" },
						""));
		mv.setViewName("redirect:/role/listPage");
		logger.info("新增系统角色成功");
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
	public ModelAndView delete(@RequestParam String ROLE_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("ROLE_ID", ROLE_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "role/delete", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS",
						new Object[] { "系统角色" }, ""));
		mv.setViewName("redirect:/role/listPage");
		logger.info("删除系统角色成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "role/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "系统角色" },
						""));
		mv.setViewName("redirect:/role/listPage");
		logger.info("修改系统角色成功");
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

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "role/listPage", pd,
				Page.class);

		List<PageData> roleModuleData = rest.postForList(
				IConstant.FFW_SERVICE_KEY, "role/listAllModule", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleModuleData", roleModuleData);

		mv.setViewName("/role/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询系统角色信息");
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

		List<PageData> roleModuleData = rest.postForList(
				IConstant.FFW_SERVICE_KEY, "role/listAllModule", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleModuleData", roleModuleData);

		mv.addObject("pd", pd);
		mv.setViewName("role/add");
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

		List<PageData> roleModuleData = rest.postForList(
				IConstant.FFW_SERVICE_KEY, "role/listAllModule", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleModuleData", roleModuleData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "role/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("role/edit");
		return mv;
	}
}
