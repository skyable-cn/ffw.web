package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.web.config.FileConfig;
import com.ffw.web.constant.IConstant;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("ladder")
public class LadderController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(LadderController.class);

	@Autowired
	RestTemplateUtil rest;

	@Autowired
	FileConfig fileConfig;

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
		
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		pd.put("MARKET_ID", user.getString("DM_ID"));


		pd.put("CDT", DateUtil.getTime());

		pd.put("STATE", IConstant.STRING_0);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "ladder/save", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "阶梯价" }, ""));
		mv.setViewName("redirect:/ladder/listPage");
		logger.info("新增阶梯价成功");
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
	public ModelAndView delete(@RequestParam String LADDER_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("LADDER_ID", LADDER_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "ladder/delete", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "阶梯价" },
						""));
		mv.setViewName("redirect:/ladder/listPage");
		logger.info("删除阶梯价成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "ladder/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "阶梯价" },
						""));
		mv.setViewName("redirect:/ladder/listPage");
		logger.info("修改阶梯价成功");
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
		
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		pd.put("MARKET_ID", user.getString("DM_ID"));

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "ladder/listPage", pd,
				Page.class);
		
		for(PageData item:page.getData()){
			String remark = item.getString("REMARK");
			List<PageData> items = new ArrayList<PageData>();
			if(StringUtils.isNotEmpty(remark)){
				String[] arry1 = remark.split(",");
				for (int i = 0; i < arry1.length; i++) {
					String[] arry2 = arry1[i].split("/");
					PageData one = new PageData();
					one.put("START", arry2[0]);
					one.put("END", arry2[1]);
					one.put("MONEY", arry2[2]);
					items.add(one);
				}
			}
			
			item.put("ITEMS", items);
		}

		mv.setViewName("/ladder/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询阶梯价信息");
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

		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		
		PageData pdm2 = new PageData();
		pdm2.put("MARKET_ID", user.getString("DM_ID"));
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		mv.addObject("pd", pd);
		mv.setViewName("ladder/add");
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

		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		
		PageData pdm2 = new PageData();
		pdm2.put("MARKET_ID", user.getString("DM_ID"));
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "ladder/find", pd,
				PageData.class);
		
		String remark = pd.getString("REMARK");
		List<PageData> items = new ArrayList<PageData>();
		if(StringUtils.isNotEmpty(remark)){
			String[] arry1 = remark.split(",");
			for (int i = 0; i < arry1.length; i++) {
				String[] arry2 = arry1[i].split("/");
				PageData one = new PageData();
				one.put("START", arry2[0]);
				one.put("END", arry2[1]);
				one.put("MONEY", arry2[2]);
				items.add(one);
			}
		}
		
		pd.put("ITEMS", items);
		
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("ladder/edit");
		return mv;
	}


	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		
		PageData pdm2 = new PageData();
		pdm2.put("MARKET_ID", user.getString("DM_ID"));
		pdm2.put("STATE", IConstant.STRING_1);
		List<PageData> goodsData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"goods/listAll", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("goodsData", goodsData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "ladder/find", pd,
				PageData.class);
		
		String remark = pd.getString("REMARK");
		List<PageData> items = new ArrayList<PageData>();
		if(StringUtils.isNotEmpty(remark)){
			String[] arry1 = remark.split(",");
			for (int i = 0; i < arry1.length; i++) {
				String[] arry2 = arry1[i].split("/");
				PageData one = new PageData();
				one.put("START", arry2[0]);
				one.put("END", arry2[1]);
				one.put("MONEY", arry2[2]);
				items.add(one);
			}
		}
		pd.put("ITEMS", items);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("ladder/info");
		return mv;
	}
}
