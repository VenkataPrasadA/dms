package com.vts.dms.dak.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vts.dms.dak.model.DakMain;



	@Repository
	public interface DakRepo 
	  extends JpaRepository<DakMain, Long> {
		
	}