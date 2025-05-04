package com.codingdojo.chorestrackerpro.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.chorestrackerpro.models.Chore;


@Repository
public interface ChoreRepository extends CrudRepository<Chore, Long>{

	@Query(value = "SELECT * FROM chores WHERE user_chores IS NULL AND deleted = false", nativeQuery = true)
	List<Chore> findAll();
	
	@Query(value = "SELECT * FROM chores WHERE user_chores = ?1 AND deleted = false", nativeQuery = true)
	List<Chore> findMyChores(Long userId);
}
