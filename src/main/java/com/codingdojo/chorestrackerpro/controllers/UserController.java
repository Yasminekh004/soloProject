package com.codingdojo.chorestrackerpro.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.chorestrackerpro.models.User;
import com.codingdojo.chorestrackerpro.services.UserService;
import com.codingdojo.chorestrackerpro.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {
	private UserService userService;
	private UserValidator userValidator;

	public UserController(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
	}

	@RequestMapping("/register")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model,
			HttpServletRequest request) {
		System.out.println("result "+result);
		System.out.println("user "+user);
		userValidator.validate(user, result);
		String password = user.getPassword();
		if (result.hasErrors()) {
			return "loginPage.jsp";
		}
		if (userService.allUsers().size() == 0) {
			userService.newUser(user, "ROLE_ADMIN");
		} else {
			userService.newUser(user, "ROLE_USER");
		}

		authWithHttpServletRequest(request, user.getEmail(), password);
		return "redirect:/";
	}

	public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
		try {
			request.login(email, password);
		} catch (ServletException e) {
			System.out.println("Error while login: " + e);
		}
	}

	@RequestMapping("/login")
	public String login(@ModelAttribute("user") User user,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, Model model) {

		if (error != null) {
			model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
		}
		if (logout != null) {
			model.addAttribute("logoutMessage", "Logout Successful!");
		}
		return "loginPage.jsp";
	}
}
