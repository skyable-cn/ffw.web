package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
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
import com.ffw.web.util.Pinyin;
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("shop")
public class ShopController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(ShopController.class);

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

		pd.put("CDT", DateUtil.getTime());
		pd.put("SHOPSTATE_ID", IConstant.STRING_1);

		pd.put("WAITACCOUNT", IConstant.STRING_0);
		pd.put("ALREADYACCOUNT", IConstant.STRING_0);
		
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		pd.put("MARKET_ID", user.getString("DM_ID"));

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "shop/save", pd,
				PageData.class);

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(
				getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest
						.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID()
						+ fileOriginaName.substring(fileOriginaName
								.lastIndexOf("."));
				File fileNew = new File(fileConfig.getDirImage()
						+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("SHOP_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_7);

				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

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

		CommonsMultipartResolver resolver = new CommonsMultipartResolver(
				getSession().getServletContext());
		if (resolver.isMultipart(getRequest())) {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) getRequest();
			Iterator<String> it = multipartHttpServletRequest.getFileNames();
			while (it.hasNext()) {
				String fileID = it.next();
				MultipartFile file = multipartHttpServletRequest
						.getFile(fileID);
				if (StringUtils.isEmpty(file.getOriginalFilename())) {
					continue;
				}
				String fileOriginaName = file.getOriginalFilename();
				String tempName = get32UUID()
						+ fileOriginaName.substring(fileOriginaName
								.lastIndexOf("."));
				File fileNew = new File(fileConfig.getDirImage()
						+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("SHOP_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_7);

				PageData pdft = rest.post(IConstant.FFW_SERVICE_KEY,
						"file/findBy", pdf, PageData.class);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdft,
						PageData.class);

				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

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
		
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		if(user.getString("ROLE_ID").equals(IConstant.STRING_3)){
			pd.put("MARKET_ID", user.getString("DM_ID"));
		}

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

		PageData pd1 = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllType", pd1,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

		PageData pd2 = new PageData();
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		pd2.put("MARKET_ID", user.getString("DM_ID"));
		List<PageData> memberData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"member/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("memberData", memberData);

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

		PageData pd1 = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllType", pd1,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);
		
		PageData pd2 = new PageData();
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);
		pd2.put("MARKET_ID", user.getString("DM_ID"));
		List<PageData> memberData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"member/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("memberData", memberData);

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
		
		PageData pd2 = new PageData();
		List<PageData> memberData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"member/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("memberData", memberData);

		PageData pd1 = new PageData();
		List<PageData> typeData = rest.postForList(IConstant.FFW_SERVICE_KEY,
				"shop/listAllType", pd1,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("typeData", typeData);

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
			pdu.put("ROLE_ID", IConstant.STRING_4);
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
