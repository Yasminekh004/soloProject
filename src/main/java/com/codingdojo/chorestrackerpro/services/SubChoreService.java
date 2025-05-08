package com.codingdojo.chorestrackerpro.services;

import java.util.List;
import java.util.Optional;

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
    
    public SubChore createSubChore(SubChore subChore) {
		return subChoreRepository.save(subChore);
	}
    public void deleteSubChore(Long id) {
		if (subChoreRepository.existsById(id)) {
			subChoreRepository.deleteById(id);
			System.out.println("SubChore has been deleted");
		} else {
			System.out.println("No SubChore with this id to be deleted");
		}
	}
    
    public void markeAsDone(Long subChoreId) {
    	Optional<SubChore> sb = subChoreRepository.findById(subChoreId);
    	if(sb.isPresent()) {
    		SubChore subChore = sb.get();
        	subChore.setDoneSub(true);
    		subChoreRepository.save(subChore);
    		System.out.println("Sub Chore is Done");
    	}   	
    	
    }
    
    public List<SubChore> getDoneSubChores(Long choreId){
    	return subChoreRepository.findByIdAndChoreSubId(choreId);
    }

}
