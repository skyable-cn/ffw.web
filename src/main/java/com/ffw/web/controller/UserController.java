package com.ffw.web.controller;

import java.util.List;

import org.apache.shiro.crypto.hash.SimpleHash;
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
import com.ffw.api.util.DateUtil;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.Pinyin;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(UserController.class);

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
		if (pd.getString("ROLE_ID").equals(IConstant.STRING_1)
				|| pd.getString("ROLE_ID").equals(IConstant.STRING_2)) {
			pd.put("DM_ID", IConstant.STRING_0);
		}

		String pinYinName = Pinyin.getPinYinHeadChar(pd.getString("NICKNAME"));
		String pinYinNameTemp = Pinyin.getPinYinHeadChar(pd
				.getString("NICKNAME"));
		int nameOrder = 1;
		while (true) {
			pd.put("USERNAME", pinYinNameTemp);
			PageData user = rest.post(IConstant.FFW_SERVICE_KEY,
					"user/findByName", pd, PageData.class);
			if (null == user) {
				break;
			}
			pinYinNameTemp = (pinYinName + nameOrder);
			nameOrder++;
		}
		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"),
				IConstant.DEFAULT_PASSWORD).toString()); // 密码加密

		rest.post(IConstant.FFW_SERVICE_KEY, "user/save", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "系统用户" },
						""));
		mv.setViewName("redirect:/user/listPage");
		logger.info("新增系统用户成功");
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
	public ModelAndView delete(@RequestParam String USER_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("USER_ID", USER_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "user/delete", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS",
						new Object[] { "系统用户" }, ""));
		mv.setViewName("redirect:/user/listPage");
		logger.info("删除系统用户成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "user/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "系统用户" },
						""));
		mv.setViewName("redirect:/user/listPage");
		logger.info("修改系统用户成功");
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

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "user/listPage", pd,
				Page.class);

		PageData pdm = new PageData();
		pdm.put("ROLEMODULE_ID", IConstant.MODULE_WEB_ID);
		List<PageData> roleData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"role/listAll", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleData", roleData);

		mv.setViewName("/user/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询系统用户信息");
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

		PageData pdm = new PageData();
		pdm.put("ROLEMODULE_ID", IConstant.MODULE_WEB_ID);
		List<PageData> roleData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"role/listAll", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleData", roleData);

		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		mv.setViewName("user/add");
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

		PageData pdm = new PageData();
		pdm.put("ROLEMODULE_ID", IConstant.MODULE_WEB_ID);
		List<PageData> roleData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"role/listAll", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleData", roleData);

		PageData pdm2 = new PageData();
		pdm2.put("SHOPSTATE_ID", IConstant.STRING_2);
		List<PageData> shopData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("shopData", shopData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "user/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("user/edit");
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm = new PageData();
		pdm.put("ROLEMODULE_ID", IConstant.MODULE_WEB_ID);
		List<PageData> roleData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"role/listAll", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("roleData", roleData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "user/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("user/info");
		return mv;
	}
}
