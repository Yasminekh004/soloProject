package com.codingdojo.chorestrackerpro.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.chorestrackerpro.models.SubChore;

@Repository
public interface SubChoreRepository extends CrudRepository<SubChore, Long>{

	List<SubChore> findByChoreSubId(Long choreId);
	
	@Query(value = "SELECT * FROM sub_chores WHERE done_sub = true AND chore_id = :choreId", nativeQuery = true)
	List<SubChore> findByIdAndChoreSubId(Long choreId);

}
