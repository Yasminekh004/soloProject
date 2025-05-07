package com.codingdojo.chorestrackerpro.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.codingdojo.chorestrackerpro.models.Chore;

@Repository
public interface ChoreRepository extends JpaRepository<Chore, Long> {

	@Query(value = "SELECT * FROM chores WHERE user_chores IS NULL AND deleted = false", nativeQuery = true)
	Page<Chore> findAll(Pageable pageable);

	@Query(value = "SELECT * FROM chores WHERE user_chores IS NULL AND deleted = false AND LOWER(title) LIKE LOWER(CONCAT('%', :keyword, '%'))", countQuery = "SELECT count(*) FROM chores WHERE user_chores IS NULL AND deleted = false AND LOWER(title) LIKE LOWER(CONCAT('%', :keyword, '%'))", nativeQuery = true)
	Page<Chore> searchAvailableChores(@Param("keyword") String keyword, Pageable pageable);

	@Query(value = "SELECT * FROM chores WHERE user_chores = ?1 AND deleted = false", nativeQuery = true)
	List<Chore> findMyChores(Long userId);
}
