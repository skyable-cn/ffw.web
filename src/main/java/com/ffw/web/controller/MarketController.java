package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("market")
public class MarketController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(MarketController.class);

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
		pd.put("DOMAIN_ID", user.getString("DM_ID"));
		
		PageData pdu = new PageData();
		String pinYinName = Pinyin.getPinYinHeadChar(pd
				.getString("MARKETNAME"));
		String pinYinNameTemp = Pinyin.getPinYinHeadChar(pd
				.getString("MARKETNAME"));
		int nameOrder = 1;
		while (true) {
			pdu.put("USERNAME", pinYinNameTemp);
			PageData usert = rest.post(IConstant.FFW_SERVICE_KEY,
					"user/findByName", pdu, PageData.class);
			if (null == usert) {
				break;
			}
			pinYinNameTemp = (pinYinName + nameOrder);
			nameOrder++;
		}
		
		pd.put("ACCOUNTER", pinYinNameTemp);
		
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "market/save", pd, PageData.class);
		
		
		PageData pds = new PageData();
		pds.put("MARKET_ID", pd.getString("MARKET_ID"));
		rest.post(IConstant.FFW_SERVICE_KEY, "service/save", pds,
				PageData.class);
		
		pdu.put("PASSWORD",
				new SimpleHash("SHA-1", pdu.getString("USERNAME"),
						IConstant.DEFAULT_PASSWORD).toString()); // 密码加密
		pdu.put("DM_ID", pd.getString("MARKET_ID"));
		pdu.put("ROLE_ID", IConstant.STRING_3);
		pdu.put("CDT", DateUtil.getTime());
		pdu.put("STATE", IConstant.STRING_1);
		rest.post(IConstant.FFW_SERVICE_KEY, "user/save", pdu,
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
				
				String tempPath = null;
				if (fileID.equals("file-0")) {
					tempPath = fileConfig.getDirImage();
				}
				if (fileID.equals("file-1")) {
					tempPath = fileConfig.getDirCert();
				}

				File fileNew = new File(
						tempPath+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("MARKET_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				
				String FILETYPE = null;

				if (fileID.equals("file-0")) {
					FILETYPE = IConstant.STRING_9;
				}
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_10;
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}
		
		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "商城模块" },
						""));
		mv.setViewName("redirect:/market/listPage");
		logger.info("新增商城模块成功");
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
	public ModelAndView delete(@RequestParam String MARKET_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("MARKET_ID", MARKET_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "market/delete", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS",
						new Object[] { "商城模块" }, ""));
		mv.setViewName("redirect:/market/listPage");
		logger.info("删除商城模块成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "market/edit", pd, PageData.class);
		
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
				
				String tempPath = null;
				if (fileID.equals("file-0")) {
					tempPath = fileConfig.getDirImage();
				}
				if (fileID.equals("file-1")) {
					tempPath = fileConfig.getDirCert();
				}

				File fileNew = new File(
						tempPath+ File.separator + tempName);
				file.transferTo(fileNew);

				PageData pdf = new PageData();
				pdf.put("REFERENCE_ID", pd.getString("MARKET_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				
				String FILETYPE = null;

				if (fileID.equals("file-0")) {
					FILETYPE = IConstant.STRING_9;
					
					PageData pdfd = new PageData();
					pdfd.put("FILE_ID", pd.getString("LGFILE_ID"));
					rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdfd,
							PageData.class);
				}
				if (fileID.equals("file-1")) {
					FILETYPE = IConstant.STRING_10;
					PageData pdfd = new PageData();
					pdfd.put("FILE_ID", pd.getString("CTFILE_ID"));
					rest.post(IConstant.FFW_SERVICE_KEY, "file/delete", pdfd,
							PageData.class);
				}
				pdf.put("FILETYPE", FILETYPE);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_EDIT_SUCCESS",
						new Object[] { "商城模块" }, ""));
		mv.setViewName("redirect:/market/listPage");
		logger.info("修改商城模块成功");
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
		if(user.getString("ROLE_ID").equals(IConstant.STRING_2)){
			pd.put("DOMAIN_ID", user.getString("DM_ID"));
		}

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "market/listPage", pd,
				Page.class);

		mv.setViewName("/market/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询商城模块信息");
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
		mv.setViewName("market/add");
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

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "market/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("market/edit");
		return mv;
	}
	
	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "market/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("market/info");
		return mv;
	}
}
