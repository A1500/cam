package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptinstitution.data.BptHospitalDetail;



/**
 * @title:IBptHospitalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public interface IBptHospitalDetailDao extends BaseCURD<BptHospitalDetail>{
	public void save(List<BptHospitalDetail> list);
	public void deleteDetail(String bpthospitalIds);
	public void batchDeleteByBptHospital(String[] fkId);
	public DataSet getHospitalTotal(ParameterSet pset);
	public DataSet getMaxYear(ParameterSet pset);
}

