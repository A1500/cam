package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;


/**
 * @title:IBptMartyrBuildingsLegalDao
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public interface IBptMartyrBuildingsLegalDao extends BaseCURD<BptMartyrBuildingsLegal>{
	public void save(List<BptMartyrBuildingsLegal> list);
	
	public void batchDeleteByBptMartyrBuildings(String[] mbuildingId);
	
}

