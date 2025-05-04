package com.codingdojo.chorestrackerpro.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.codingdojo.chorestrackerpro.models.Chore;
import com.codingdojo.chorestrackerpro.models.User;
import com.codingdojo.chorestrackerpro.repositories.ChoreRepository;
import com.codingdojo.chorestrackerpro.repositories.UserRepository;

@Service
public class ChoreService {
	
	@Autowired
	ChoreRepository choreRepository;
	
	@Autowired
	UserRepository userRepository;
	
	public List<Chore> AllChores(){
		return choreRepository.findAll();
	}
	
	public Page<Chore> getPagedChores(int page, int size, String keyword) {
        Pageable pageable = PageRequest.of(page, size);
        if (keyword != null && !keyword.isEmpty()) {
            return choreRepository.searchAvailableChores(keyword, pageable);
        }
        return choreRepository.findAll(pageable);
    }
	
	public List<Chore> AllMyChores(Long userId){
		return choreRepository.findMyChores(userId);
	}
	
	public Chore createChore(Chore chore) {
		chore.setDeleted(false);
		return choreRepository.save(chore);
	}

	public Chore findChore(Long id) {
		Optional<Chore> optionalChore = choreRepository.findById(id);
		if (optionalChore.isPresent()) {
			return optionalChore.get();
		} else {
			return null;
		}
	}
	
	public Chore updateChore(Chore c) {
		Optional<Chore> optionalChore = choreRepository.findById(c.getId());
		if (optionalChore.isPresent()) {
			Chore chore = optionalChore.get();
			chore.setTitle(c.getTitle());
			chore.setDescription(c.getDescription());
			chore.setLocation(c.getLocation());
			chore.setDueDate(c.getDueDate());
			return choreRepository.save(chore);
		} else {
			System.out.println("No chore with this id to be updated");
			return null;
		}
	}
	
	public Chore addToUser(Chore c, Long userId) {
		Optional<Chore> optionalChore = choreRepository.findById(c.getId());
		Optional<User> optionaluser = userRepository.findById(userId);
		if (optionalChore.isPresent()) {
			Chore chore = optionalChore.get();
			chore.setTitle(c.getTitle());
			chore.setDescription(c.getDescription());
			chore.setLocation(c.getLocation());
			chore.setUserChores(optionaluser.get());
			chore.setDueDate(c.getDueDate());
			return choreRepository.save(chore);
		} else {
			System.out.println("No chore with this id to be updated");
			return null;
		}
	}
	
	public void removeChore(Long id) {
		Optional<Chore> optionalChore = choreRepository.findById(id);
		if (optionalChore.isPresent()) {
			Chore chore = optionalChore.get();
			chore.setDeleted(true);
			choreRepository.save(chore);
			System.out.println("Chore has been deleted");
		} else {
			System.out.println("No Chore with this id to be deleted");
		}
	}
	
	public void deleteChore(Long id) {
		if (choreRepository.existsById(id)) {
			choreRepository.deleteById(id);
			System.out.println("Chore has been deleted");
		} else {
			System.out.println("No Chore with this id to be deleted");
		}
	}
}
