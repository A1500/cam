package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;


/**
 * @title:IBptHospitalLegalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public interface IBptHospitalLegalDao extends BaseCURD<BptHospitalLegal>{
	public void save(List<BptHospitalLegal> list);
	
	public void batchDeleteByBptHospitalDetail(String[] hospitalDetailId);
	
}

