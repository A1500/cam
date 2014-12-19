package com.inspur.cams.bpt.bptinstitution.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.sql.*;

import org.loushang.next.data.*;

import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;



/**
 * @title:IBptMartyrBuildingsDomain
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public interface IBptMartyrBuildingsDomain {

   public void saveBptMartyrBuildings(List<BptMartyrBuildings> list);
	public void saveBptMartyrBuildingsLegal(List<BptMartyrBuildingsLegal> list);
	public DataSet queryBptMartyrBuildingsLegal(ParameterSet pset);
	public void saveBptMartyrBuildingsLegalList(BptMartyrBuildings bptmartyrbuildings, List<BptMartyrBuildingsLegal> list);

	

	public DataSet queryBptMartyrBuildings(ParameterSet pset);


	public void delete(List<String> list);

 }