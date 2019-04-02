package com.ffw.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Menu;
import com.ffw.api.model.PageData;
import com.ffw.web.constant.IConstant;
import com.ffw.web.tasker.MenuStartupRunner;
import com.ffw.web.util.RestTemplateUtil;

@Controller
public class IndexController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping("/goLogin")
	public ModelAndView goLogin() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("login");
		mv.addObject(IConstant.SYSTEM_NAME, SYSTEM_NAME);
		return mv;
	}

	@RequestMapping("/")
	public ModelAndView wellcome() {
		ModelAndView mv = this.getModelAndView();
		HttpSession session = getSession();
		if (null != session.getAttribute(IConstant.USER_SESSION)) {
			mv.setViewName("redirect:/index");
		} else {
			mv.setViewName("redirect:/goLogin");
		}
		return mv;
	}

	@RequestMapping("/login")
	public ModelAndView login() {

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		try {
			String sessionCode = (String) getSession().getAttribute(
					IConstant.LOGIN_CODE); // 获取session中的验证码
			String USERNAME = pd.getString("USERNAME");
			String PASSWORD = pd.getString("PASSWORD");
			String CODE = pd.getString("CODE");
			if (StringUtils.isNotEmpty(USERNAME)
					&& StringUtils.isNotEmpty(PASSWORD)
					&& StringUtils.isNotEmpty(CODE)) {
				if (sessionCode.equalsIgnoreCase(CODE)) {
					PageData userTemp = rest.post(IConstant.FFW_SERVICE_KEY,
							"user/findByUserName", pd, PageData.class);
					if (null == userTemp) {
						errInfo = "对不起,未发现此账户相关信息!";
					} else {
						if (userTemp.getString("PASSWORD").equals(
								new SimpleHash("SHA-1", userTemp
										.getString("USERNAME"), PASSWORD)
										.toString())) {
							if (IConstant.STRING_0.equals(userTemp
									.getString("STATE"))) {
								errInfo = "对不起,当前账户状态被停用";
							} else {

								getSession().setAttribute(
										IConstant.USER_SESSION, userTemp);
								getSession().removeAttribute(
										IConstant.LOGIN_CODE);
							}
						} else {
							errInfo = "对不起,账户/密码错误";
						}
					}
				} else {
					errInfo = "验证码错误";
				}
			} else {
				errInfo = "参数非法";
			}
		} catch (

		Exception e) {
			errInfo = "登陆失败";
			logger.error("登陆失败", e);
		}
		if (StringUtils.isNotEmpty(errInfo)) {
			mv.addObject("errInfo", errInfo);
			mv.addObject(IConstant.SYSTEM_NAME, SYSTEM_NAME);
			mv.setViewName("login");
		} else {
			mv.setViewName("redirect:/index");
		}
		return mv;

	}

	@RequestMapping("/index")
	public ModelAndView index() throws Exception {
		HttpSession session = getSession();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData user = (PageData) getSession().getAttribute(
				IConstant.USER_SESSION);

		List<Menu> menuLast = MenuStartupRunner.systemMenus.get(Integer
				.parseInt(user.getString("ROLE_ID")));

		if (CollectionUtils.isEmpty(menuLast)) {
			getSession().removeAttribute(IConstant.USER_SESSION);
			mv.addObject("errInfo", "未发现可用菜单选项");
			mv.addObject(IConstant.SYSTEM_NAME, SYSTEM_NAME);
			mv.setViewName("login");
		} else {
			getSession().setAttribute(IConstant.MENU_LIST, menuLast);
			mv.setViewName("/index/main");
			session.setAttribute(IConstant.SYSTEM_NAME, SYSTEM_NAME);

			String menuUrl = null;
			Menu first = menuLast.get(0);
			if (!first.getUrl().equals("#")) {
				menuUrl = first.getUrl();
			} else {
				menuUrl = first.getSubMenu().get(0).getUrl();
			}

			session.setAttribute(IConstant.MENU_FIRST_DEFAULT, menuUrl);

		}

		mv.addObject("pd", pd);

		return mv;

	}

	@RequestMapping("/defaultPage")
	public ModelAndView defaultPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/index/defaultPage");
		return mv;
	}

	@RequestMapping("/logout")
	public ModelAndView logout() throws Exception {
		getSession().removeAttribute(IConstant.USER_SESSION);
		ModelAndView mv = this.getModelAndView();

		PageData pd = new PageData();
		pd = this.getPageData();

		mv.addObject(IConstant.SYSTEM_NAME, SYSTEM_NAME);
		mv.setViewName("login");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping("/unauthorized")
	public ModelAndView unauthorizedPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("unauthorized");
		return mv;
	}
}
