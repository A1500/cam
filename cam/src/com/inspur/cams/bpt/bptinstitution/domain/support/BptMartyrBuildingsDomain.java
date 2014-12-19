package com.inspur.cams.bpt.bptinstitution.domain.support;

import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import org.loushang.next.data.*;
//import org.loushang.util.Page;
//import org.loushang.util.RowSelection;
import org.osoa.sca.annotations.*;

import com.inspur.cams.bpt.bptinstitution.dao.IBptMartyrBuildingsDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptMartyrBuildingsLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptMartyrBuildingsDomain;


/**
 * @title:BptMartyrBuildingsDomain
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public class BptMartyrBuildingsDomain implements IBptMartyrBuildingsDomain {

	private IBptMartyrBuildingsDao bptmartyrbuildingsDao;
	
	private IBptMartyrBuildingsLegalDao bptmartyrbuildingslegalDao;

	@Reference
	public void setBptMartyrBuildingsDao(IBptMartyrBuildingsDao bptmartyrbuildingsDao) {
		this.bptmartyrbuildingsDao = bptmartyrbuildingsDao;
	}

	public void saveBptMartyrBuildings(List<BptMartyrBuildings> list) {
		this.bptmartyrbuildingsDao.save(list);

	}
	@Reference
	public void setBptMartyrBuildingsLegalDao(IBptMartyrBuildingsLegalDao bptmartyrbuildingslegalDao) {
		this.bptmartyrbuildingslegalDao = bptmartyrbuildingslegalDao;
	}



	public void saveBptMartyrBuildingsLegal(List<BptMartyrBuildingsLegal> list) {
		if (list != null && !list.isEmpty()) {
			this.bptmartyrbuildingslegalDao.save(list);
		}
	}
	public DataSet queryBptMartyrBuildingsLegal(ParameterSet pset) {
		return bptmartyrbuildingslegalDao.query(pset);
	}
	public void saveBptMartyrBuildingsLegalList(BptMartyrBuildings bptmartyrbuildings, List<BptMartyrBuildingsLegal> line) {
		List bptmartyrbuildingsList = new ArrayList();
		bptmartyrbuildingsList.add(bptmartyrbuildings);
		this.bptmartyrbuildingsDao.save(bptmartyrbuildingsList);
		if (line != null && !line.isEmpty()) {
			this.bptmartyrbuildingslegalDao.save(line);
		}
	}
	

	public void delete(List<String> list) {
		String[] bptmartyrbuildingsIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			this.bptmartyrbuildingsDao.batchDelete(bptmartyrbuildingsIds);
			
			this.bptmartyrbuildingslegalDao.batchDeleteByBptMartyrBuildings(bptmartyrbuildingsIds);
		}

	}

	public DataSet queryBptMartyrBuildings(ParameterSet pset) {
		return bptmartyrbuildingsDao.query(pset);
	}






}