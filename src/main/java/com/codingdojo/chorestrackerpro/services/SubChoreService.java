package com.codingdojo.chorestrackerpro.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.chorestrackerpro.models.SubChore;
import com.codingdojo.chorestrackerpro.repositories.SubChoreRepository;

@Service
public class SubChoreService {
	
	private final SubChoreRepository subChoreRepository;

    public SubChoreService(SubChoreRepository subChoreRepository) {
        this.subChoreRepository = subChoreRepository;
    }

    public List<SubChore> getSubChoreByChore(Long choreId) {
        return subChoreRepository.findByChoreSubId(choreId);
    }
    
    public SubChore createSubChore(SubChore note) {
		return subChoreRepository.save(note);
	}
    public void deleteSubChore(Long id) {
		if (subChoreRepository.existsById(id)) {
			subChoreRepository.deleteById(id);
			System.out.println("SubChore has been deleted");
		} else {
			System.out.println("No SubChore with this id to be deleted");
		}
	}

}
