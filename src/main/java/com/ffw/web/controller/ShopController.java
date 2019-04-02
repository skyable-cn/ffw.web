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
@RequestMapping("shop")
public class ShopController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(ShopController.class);

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

		rest.post(IConstant.FFW_SERVICE_KEY, "shop/save", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "商户" }, ""));
		mv.setViewName("redirect:/shop/listPage");
		logger.info("新增商户成功");
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
	public ModelAndView delete(@RequestParam String SHOP_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("SHOP_ID", SHOP_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "shop/delete", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "商户" },
						""));
		mv.setViewName("redirect:/shop/listPage");
		logger.info("删除商户成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "shop/edit", pd, PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "商户" },
						""));
		mv.setViewName("redirect:/shop/listPage");
		logger.info("修改商户成功");
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

		PageData pdm = new PageData();
		List<PageData> stateData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllState", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("stateData", stateData);

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "shop/listPage", pd,
				Page.class);

		mv.setViewName("/shop/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商户信息");
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
		mv.setViewName("shop/add");
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
		List<PageData> stateData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllState", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("stateData", stateData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("shop/edit");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm = new PageData();
		List<PageData> stateData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllState", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("stateData", stateData);

		PageData pdm2 = new PageData();
		pdm2.put("SHOP_ID", pd.getString("SHOP_ID"));
		List<PageData> approveData = rest.postForList(
				IConstant.FFW_SERVICE_KEY, "shop/listAllApprove", pdm2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("approveData", approveData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("shop/info");
		return mv;
	}

	@RequestMapping(value = "/goAuditing")
	public ModelAndView goAuditing() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdm = new PageData();
		pdm.put("SHOP_ID", pd.getString("SHOP_ID"));
		List<PageData> approveData = rest.postForList(
				IConstant.FFW_SERVICE_KEY, "shop/listAllApprove", pdm,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("approveData", approveData);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("shop/auditing");
		return mv;
	}

	@RequestMapping(value = "/auditing")
	public ModelAndView auditing() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdi = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pd,
				PageData.class);
		pdi.put("SHOPSTATE_ID", pd.getString("SHOPSTATE_ID"));
		rest.post(IConstant.FFW_SERVICE_KEY, "shop/edit", pdi, PageData.class);

		pd.put("CDT", DateUtil.getTime());
		rest.post(IConstant.FFW_SERVICE_KEY, "shop/saveApprove", pd,
				PageData.class);

		if (pd.getString("SHOPSTATE_ID").equals(IConstant.STRING_2)) {

			PageData pdu = new PageData();
			String pinYinName = Pinyin.getPinYinHeadChar(pdi
					.getString("SHOPNAME"));
			String pinYinNameTemp = Pinyin.getPinYinHeadChar(pdi
					.getString("SHOPNAME"));
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
			pdu.put("PASSWORD",
					new SimpleHash("SHA-1", pdu.getString("USERNAME"),
							IConstant.DEFAULT_PASSWORD).toString()); // 密码加密
			pdu.put("DM_ID", pdi.getString("SHOP_ID"));
			pdu.put("ROLE_ID", IConstant.STRING_3);
			pdu.put("CDT", DateUtil.getTime());
			pdu.put("STATE", IConstant.STRING_1);
			rest.post(IConstant.FFW_SERVICE_KEY, "user/save", pdu,
					PageData.class);

			pdi = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pd,
					PageData.class);
			pdi.put("ACCOUNTER", pdu.getString("USERNAME"));
			rest.post(IConstant.FFW_SERVICE_KEY, "shop/edit", pdi,
					PageData.class);
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_APPROVE_SUCCESS",
						new Object[] { "审核商户" }, ""));
		mv.setViewName("redirect:/shop/listPage");
		logger.info("审核商户成功");
		return mv;
	}

}
