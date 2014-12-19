package com.inspur.cams.bpt.bptinstitution.domain;

import java.util.List;
import org.loushang.next.data.*;

import com.inspur.cams.bpt.bptinstitution.data.BptHospital;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;

/**
 * @title:IBptHospitalDomain
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public interface IBptHospitalDomain {

   public void saveBptHospital(List<BptHospital> list);
	public void saveBptHospitalLegal(List<BptHospitalLegal> list);
	public DataSet queryBptHospitalLegal(ParameterSet pset);
	public void saveBptHospitalLegalList(BptHospital bpthospital, List<BptHospitalLegal> list);
	public void updateBptHospitalLegal(BptHospitalLegal bptHospitalLegal);
	public void insertBptHospitalLegal(BptHospitalLegal bptHospitalLegal);
	

	public DataSet queryBptHospital(ParameterSet pset);
	public DataSet queryBptHospitalDetail(ParameterSet pset);

	public void delete(List<String> list);
	public DataSet getMaxYear(ParameterSet pset);
	public void hospitalDelete(String[] list);

 }