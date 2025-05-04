package com.codingdojo.chorestrackerpro.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.chorestrackerpro.models.Chore;
import com.codingdojo.chorestrackerpro.models.SubChore;
import com.codingdojo.chorestrackerpro.models.User;
import com.codingdojo.chorestrackerpro.services.ChoreService;
import com.codingdojo.chorestrackerpro.services.SubChoreService;
import com.codingdojo.chorestrackerpro.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	
	@Autowired
	ChoreService choreService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	SubChoreService subChoreService;
	
	// Chore
	
	@RequestMapping(value = { "/", "/dashboard" })
	public String home(Principal principal, Model model, HttpSession session,
			@RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "4") int size,
            @RequestParam(required = false) String keyword) {
		if (principal == null) {
			return "redirect:/login";
		}
		
		
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("user", user);
		session.setAttribute("userId", user.getId());
		if (user != null) {
			user.setLastLogin(new Date());
			userService.updateUser(user);
		}
		if (user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
			model.addAttribute("currentUser", userService.findByEmail(email));
			model.addAttribute("users", userService.allUsers());
			return "adminPage.jsp";
		}
		
		Long id = (Long) session.getAttribute("userId");
		//List<Chore> chores = choreService.AllChores();
		Page<Chore> chores = choreService.getPagedChores(page, size, keyword);
		model.addAttribute("chores", chores);
		model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", chores.getTotalPages());
        model.addAttribute("keyword", keyword);
				
		List<Chore> myChores = choreService.AllMyChores(id);
		model.addAttribute("myChores", myChores);
				
		return "dashboard.jsp";
	}	
	
	
	@GetMapping("/chores/new")
	public String newChore(@ModelAttribute("chore") Chore project, Model model, HttpSession session) {
		model.addAttribute("user", userService.findById((Long) session.getAttribute("userId")));
		return "newChore.jsp";
	}

	@PostMapping("/chores/new")
	public String create(@Valid @ModelAttribute("chore") Chore chore, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			return "newChore.jsp";
		} else {
			choreService.createChore(chore);
			return "redirect:/";
		}
	}
	
	@GetMapping("/chores/edit/{id}")
	public String edit(@PathVariable("id") Long id, Model model) {

		Chore chore = choreService.findChore(id);
		model.addAttribute("chore", chore);
		model.addAttribute("subChore", new SubChore());
		return "editChore.jsp";
	}

	@PutMapping("/chores/{id}")
	public String update(@Valid @ModelAttribute("chore") Chore chore, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("chore", chore);
			return "editChore.jsp";
		} else {
			choreService.updateChore(chore);
			return "redirect:/";
		}
	}
	
	@DeleteMapping("/chores/{id}")
	public String delete(@PathVariable("id") Long id, Model model, HttpSession session) {
		//choreService.deleteChore(id);		
		//model.addAttribute("point", ss.getPoints());
		return "redirect:/";
	}
	
// /chores/addPoints
	
	@GetMapping("/chores/addPoints/{id}")
	public String addPoints(@PathVariable("id") Long id, Model model, HttpSession session) {
		Chore  ss = choreService.findChore(id);
		Long idUser = (Long) session.getAttribute("userId");
		
		User us = userService.findById(idUser);
		
		
		
		us.setTotalPoints(us.getTotalPoints()+ss.getPoints());
		userService.updateUser(us);
		
		ArrayList<String> logs = (ArrayList<String>) session.getAttribute("logs");

		if (logs == null) {
		    logs = new ArrayList<>();
		}
		
		if(logs.size()>4) {
			logs.remove(4);
		}
		
		Date date = new Date();
		SimpleDateFormat sp = new SimpleDateFormat("MMMM dd yyyy HH:mm:ss");
		String dateNow = sp.format(date);

		logs.add(0,"You completed "+ss.getTitle()+" at ("+dateNow+") and eraned "+ss.getPoints());
		
		session.setAttribute("logs", logs);
		choreService.removeChore(id);	
		return "redirect:/";
	}
	
	@GetMapping("/chores/addToUser/{id}/add")
	public String addToUser(@PathVariable("id") Long id, HttpSession session) {
		
		Chore ch = choreService.findChore(id);
		User user = userService.findById((Long) session.getAttribute("userId"));
		
		ch.setUserChores(user);
		choreService.updateChore(ch);
		return "redirect:/";
		
	}
	
	
	@GetMapping("/chores/{id}")
	public String show(@PathVariable Long id, Model model, HttpSession session) {

		Chore chore = choreService.findChore(id);
		
		Long idUser = (Long) session.getAttribute("userId");
		if (idUser == null) {
			return "redirect:/dashboard";
		}
		model.addAttribute("subChore", new SubChore());

		List<SubChore> subChoreList = subChoreService.getSubChoreByChore(id);
		model.addAttribute("chore", chore);
		model.addAttribute("subChoreList", subChoreList);
		model.addAttribute("subChoreListSize", subChoreList.size());
		model.addAttribute("idUser", idUser);
		
		return "showChore.jsp";
	}
	
	@PostMapping("/chores/{choreId}/subChore/new")
	public String createNewNote(@Valid @ModelAttribute("subChore") SubChore subChore, BindingResult result,
			@PathVariable("choreId") Long id, Model model, HttpSession session) {

		Chore chore = choreService.findChore(id);
	
		if (result.hasErrors()) {							
			model.addAttribute("chore", chore);
			List<SubChore> subChoreList = subChoreService.getSubChoreByChore(id);
			model.addAttribute("subChoreList", subChoreList);
			return "showChore.jsp";
		}
		subChore.setChore_sub(chore);
		subChoreService.createSubChore(subChore);
		
		return "redirect:/chores/edit/"+id;
	}
	
	
	@GetMapping("/errorPage")
	public String errorRoute() {
		
		return "redirect:/dashboard";
	}
}
