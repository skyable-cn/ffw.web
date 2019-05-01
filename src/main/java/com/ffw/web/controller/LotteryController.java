package com.ffw.web.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
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
import com.ffw.web.util.RestTemplateUtil;

@Controller
@RequestMapping("lottery")
public class LotteryController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(LotteryController.class);

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
		pd.put("STATE", IConstant.STRING_0);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "lottery/save", pd,
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
				pdf.put("REFERENCE_ID", pd.getString("LOTTERY_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_4);
				rest.post(IConstant.FFW_SERVICE_KEY, "file/save", pdf,
						PageData.class);
			}
		}

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_ADD_SUCCESS", new Object[] { "抽奖" }, ""));
		mv.setViewName("redirect:/lottery/listPage");
		logger.info("新增抽奖成功");
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
	public ModelAndView delete(@RequestParam String LOTTERY_ID)
			throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("LOTTERY_ID", LOTTERY_ID);

		rest.post(IConstant.FFW_SERVICE_KEY, "lottery/delete", pd,
				PageData.class);

		mv.addObject(
				"msg",
				getMessageUrl("MSG_CODE_DELETE_SUCCESS", new Object[] { "抽奖" },
						""));
		mv.setViewName("redirect:/lottery/listPage");
		logger.info("删除抽奖成功");

		return mv;
	}

	@RequestMapping(value = "/open")
	@ResponseBody
	public ModelAndView open(@RequestParam String LOTTERY_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("LOTTERY_ID", LOTTERY_ID);
		pd.put("STATE", IConstant.STRING_1);
		rest.post(IConstant.FFW_SERVICE_KEY, "lottery/edit", pd, PageData.class);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "lottery/find", pd,
				PageData.class);

		PageData pdr = new PageData();
		pdr.put("LOTTERY_ID", LOTTERY_ID);
		pdr.put("LIMITPEOPLE", Integer.parseInt(pd.getString("LIMITPEOPLE")));
		pdr.put("STATE", IConstant.STRING_1);
		rest.post(IConstant.FFW_SERVICE_KEY, "lotteryrecord/editOpen", pdr,
				PageData.class);

		mv.addObject("msg",
				getMessageUrl("MSG_CODE_SUCCESS", new Object[] { "开奖抽奖" }, ""));
		mv.setViewName("redirect:/lottery/listPage");
		logger.info("开奖抽奖成功");

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

		rest.post(IConstant.FFW_SERVICE_KEY, "lottery/edit", pd, PageData.class);

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
				pdf.put("REFERENCE_ID", pd.getString("LOTTERY_ID"));
				pdf.put("FILENAME", fileOriginaName);

				String FILESIZE = new DecimalFormat("#.000").format(file
						.getSize() * 1.000 / 1024 / 1024);
				if (FILESIZE.startsWith(".")) {
					FILESIZE = IConstant.STRING_0 + FILESIZE;
				}
				pdf.put("FILESIZE", FILESIZE);
				pdf.put("FILEPATH", tempName);
				pdf.put("FILETYPE", IConstant.STRING_4);

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
				getMessageUrl("MSG_CODE_EDIT_SUCCESS", new Object[] { "抽奖" },
						""));
		mv.setViewName("redirect:/lottery/listPage");
		logger.info("修改抽奖成功");
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

		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "lottery/listPage",
				pd, Page.class);

		mv.setViewName("/lottery/list");
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		logger.info("分页查询抽奖信息");
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
		mv.setViewName("lottery/add");
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

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "lottery/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("lottery/edit");
		return mv;
	}

	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "lottery/find", pd,
				PageData.class);
		mv.addObject("pd", pd); // 放入视图容器

		mv.setViewName("lottery/info");
		return mv;
	}

}
