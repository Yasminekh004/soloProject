package com.codingdojo.chorestrackerpro.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.chorestrackerpro.models.Chore;
import com.codingdojo.chorestrackerpro.models.Comment;
import com.codingdojo.chorestrackerpro.models.SubChore;
import com.codingdojo.chorestrackerpro.models.User;
import com.codingdojo.chorestrackerpro.services.ChoreService;
import com.codingdojo.chorestrackerpro.services.CommentService;
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

	@Autowired
	CommentService commentService;

	// Chore

	@RequestMapping(value = { "/", "/dashboard" })
	public String home(Principal principal, Model model, HttpSession session,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "4") int size,
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
			
			Page<User> allUsers = userService.getAllUsers(page, size);
			model.addAttribute("currentPage", page);
			model.addAttribute("totalPages", allUsers.getTotalPages());
			
			model.addAttribute("users", allUsers);
			return "adminPage.jsp";
		}

		Long id = (Long) session.getAttribute("userId");
		// List<Chore> chores = choreService.AllChores();

		List<Comment> myComments = commentService.allNotReadCommentsForUser(id);

		Page<Chore> chores = choreService.getPagedChores(page, size, keyword);
		model.addAttribute("chores", chores);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", chores.getTotalPages());
		model.addAttribute("keyword", keyword);
		model.addAttribute("myCommentsSize", myComments.size());

		model.addAttribute("myComments", myComments);

		List<Chore> myChores = choreService.AllMyChores(id);

		Map<Long, Integer> totalSubChoreCount = new HashMap<>();
		Map<Long, Integer> doneSubChoreCount = new HashMap<>();

		for (Chore chore : myChores) {
			Long choreId = chore.getId();
			List<SubChore> subChores = subChoreService.getSubChoreByChore(choreId);
			totalSubChoreCount.put(choreId, subChores.size());

			List<SubChore> doneSubChores = subChoreService.getDoneSubChores(choreId); // You need to implement this if
																						// not done
			doneSubChoreCount.put(choreId, doneSubChores.size());
		}

		model.addAttribute("myChores", myChores);
		model.addAttribute("totalSubChoreCount", totalSubChoreCount);
		model.addAttribute("doneSubChoreCount", doneSubChoreCount);

		return "dashboard.jsp";
	}

	@GetMapping("/chores/new")
	public String newChore(Principal principal, @ModelAttribute("chore") Chore project, Model model,
			HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}
		model.addAttribute("user", userService.findById((Long) session.getAttribute("userId")));
		return "newChore.jsp";
	}

	@PostMapping("/chores/new")
	public String create(Principal principal, @Valid @ModelAttribute("chore") Chore chore, BindingResult result,
			HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}
		if (result.hasErrors()) {
			return "newChore.jsp";
		} else {
			choreService.createChore(chore);
			return "redirect:/";
		}
	}

	@GetMapping("/chores/edit/{id}")
	public String edit(Principal principal, @PathVariable("id") Long id, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}

		Chore chore = choreService.findChore(id);
		model.addAttribute("chore", chore);
		model.addAttribute("subChore", new SubChore());
		return "editChore.jsp";
	}

	@PutMapping("/chores/{id}")
	public String update(Principal principal, @Valid @ModelAttribute("chore") Chore chore, BindingResult result,
			Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		if (result.hasErrors()) {
			model.addAttribute("chore", chore);
			return "editChore.jsp";
		} else {
			choreService.updateChore(chore);
			return "redirect:/";
		}
	}

	@GetMapping("/delete/{id}")
	public String delete(Principal principal, @PathVariable("id") Long id, Model model, HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}
		choreService.deleteChore(id);
		return "redirect:/";
	}

	@GetMapping("/chores/addPoints/{id}")
	public String addPoints(Principal principal, @PathVariable("id") Long id, Model model, HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}
		Chore ss = choreService.findChore(id);
		Long idUser = (Long) session.getAttribute("userId");

		User us = userService.findById(idUser);

		us.setTotalPoints(us.getTotalPoints() + ss.getPoints());
		userService.updateUser(us);

		@SuppressWarnings("unchecked")
		ArrayList<String> logs = (ArrayList<String>) session.getAttribute("logs");

		if (logs == null) {
			logs = new ArrayList<>();
		}

		if (logs.size() > 4) {
			logs.remove(4);
		}

		Date date = new Date();
		SimpleDateFormat sp = new SimpleDateFormat("MMMM dd yyyy HH:mm:ss");
		String dateNow = sp.format(date);

		logs.add(0, "You completed " + ss.getTitle() + " at (" + dateNow + ") and eraned " + ss.getPoints());

		session.setAttribute("logs", logs);
		choreService.removeChore(id);
		return "redirect:/";
	}

	@GetMapping("/chores/addToUser/{id}/add")
	public String addToUser(Principal principal, @PathVariable("id") Long id, HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}

		Chore ch = choreService.findChore(id);
		User user = userService.findById((Long) session.getAttribute("userId"));

		ch.setUserChores(user);
		choreService.updateChore(ch);
		return "redirect:/";

	}

	@GetMapping("/chores/{id}")
	public String show(Principal principal, @PathVariable Long id, Model model, HttpSession session) {
		if (principal == null) {
			return "redirect:/login";
		}

		Chore chore = choreService.findChore(id);
		Long idUser = (Long) session.getAttribute("userId");
		if (idUser == null) {
			return "redirect:/dashboard";
		}
		model.addAttribute("subChore", new SubChore());

		User user = userService.findById(idUser);

		int isAddedToUser = choreService.IsAddedToUser(id, idUser);

		List<SubChore> subChoreList = subChoreService.getSubChoreByChore(id);
		List<SubChore> doneSubChoreList = subChoreService.getDoneSubChores(id);
		model.addAttribute("chore", chore);
		model.addAttribute("subChoreList", subChoreList);
		model.addAttribute("subChoreListSize", subChoreList.size());
		model.addAttribute("doneSubChoreListSize", doneSubChoreList.size());
		model.addAttribute("user", user);
		model.addAttribute("isAddedToUser", isAddedToUser);

		return "showChore.jsp";
	}

	@PostMapping("/chores/{choreId}/subChore/new")
	public String createNewNote(Principal principal, @Valid @ModelAttribute("subChore") SubChore subChore,
			BindingResult result, @PathVariable("choreId") Long id, Model model, HttpSession session) {

		if (principal == null) {
			return "redirect:/login";
		}

		Chore chore = choreService.findChore(id);

		if (result.hasErrors()) {
			model.addAttribute("chore", chore);
			List<SubChore> subChoreList = subChoreService.getSubChoreByChore(id);
			model.addAttribute("subChoreList", subChoreList);
			return "showChore.jsp";
		}
		subChore.setChore_sub(chore);
		subChoreService.createSubChore(subChore);

		return "redirect:/chores/edit/" + id;
	}

	@GetMapping("/error")
	public String errorRoute() {

		return "redirect:/dashboard";
	}

	// Admin View

	@GetMapping("/user/{id}")
	public String userInfo(Principal principal, @PathVariable Long id, Model model,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "4") int size,
			@RequestParam(required = false) String keyword) {
		if (principal == null) {
			return "redirect:/login";
		}

		model.addAttribute("userInfo", userService.findById(id));
		List<Chore> userChores = choreService.AllMyChores(id);
		model.addAttribute("userChores", userChores);

		Page<Chore> allChores = choreService.getPagedChores(page, size, keyword);
		model.addAttribute("allChores", allChores);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", allChores.getTotalPages());
		model.addAttribute("keyword", keyword);
		model.addAttribute("comment", new Comment());

		return "showUserInfo.jsp";
	}

	@GetMapping("/chores/addToUser/{useId}/chore/{choreId}/add")
	public String addToOtherUser(Principal principal, @PathVariable("choreId") Long choreId,
			@PathVariable("useId") Long useId) {
		if (principal == null) {
			return "redirect:/login";
		}

		Chore ch = choreService.findChore(choreId);
		User user = userService.findById(useId);

		ch.setUserChores(user);
		choreService.updateChore(ch);
		return "redirect:/user/" + useId;

	}

	// Create New Comment

	@PostMapping("/comment/{useId}/add")
	public String addComment(Principal principal, @Valid @ModelAttribute("comment") Comment comment,
			@PathVariable("useId") Long useId, BindingResult result, HttpSession session, Model model) {

		if (principal == null) {
			return "redirect:/login";
		}
		
		System.out.println("Hererererer");

		User userReader = userService.findById(useId);

		Long id = (Long) session.getAttribute("userId");
		User userWriter = userService.findById(id);
		
		if (result.hasErrors()) {
			User userInfo = userService.findById(id);
	        model.addAttribute("userInfo", userInfo);
	        model.addAttribute("comment", comment);
			return "showUserInfo.jsp";
		}		
		
		comment.setCommentWriter(userWriter);
		comment.setCommentReader(userReader);

		commentService.createComment(comment);
		return "redirect:/user/" + useId;
		
	}

	// View user Comment
	@GetMapping("/inArchive")
	public String putInArchive(Principal principal, HttpSession session) {

		if (principal == null) {
			return "redirect:/login";
		}

		Long id = (Long) session.getAttribute("userId");
		commentService.removComment(id);
		return "redirect:/";

	}

	@GetMapping("/seeArchive")
	public String getUserArchive(Principal principal, HttpSession session, Model model,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "6") int size, @RequestParam(defaultValue = "favorie") String sortBy) {

		if (principal == null) {
			return "redirect:/login";
		}

		Long id = (Long) session.getAttribute("userId");
		Page<Comment> allComments = commentService.allReadCommentsForUser(id, page, size, sortBy);
		model.addAttribute("currentPageComments", page);
		model.addAttribute("totalPagesComments", allComments.getTotalPages());
		model.addAttribute("allComments", allComments);
		return "archive.jsp";

	}

	@GetMapping("/chore/{choreId}/markAsDone/{subChoreid}")
	public String markeAsDone(Principal principal, @PathVariable("subChoreid") Long subChoreid,
			@PathVariable("choreId") Long choreId) {
		if (principal == null) {
			return "redirect:/login";
		}
		subChoreService.markeAsDone(subChoreid);
		return "redirect:/chores/" + choreId;

	}
	
	@GetMapping("/addToFavorie/{id}")
	public String addToFavorie(@PathVariable("id") Long id) {
		commentService.addToFavorie(id);
		return "redirect:/seeArchive";
	}
}
