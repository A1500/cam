package com.inspur.cams.bpt.bptinstitution.domain.support;

import java.util.*;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.*;
import org.osoa.sca.annotations.*;

import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalLegalDao;
import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptHospital;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptHospitalDomain;



/**
 * @title:BptHospitalDomain
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public class BptHospitalDomain implements IBptHospitalDomain {

	private IBptHospitalDao bpthospitalDao;
	
	private IBptHospitalLegalDao bpthospitallegalDao;
	
	private BptHospitalDetailDao bpthospitalDetailDao;
	

	@Reference
	public void setBptHospitalDao(IBptHospitalDao bpthospitalDao) {
		this.bpthospitalDao = bpthospitalDao;
	}
	
	public void saveBptHospital(List<BptHospital> list) {
		this.bpthospitalDao.save(list);

	}
	@Reference
	public void setBptHospitalLegalDao(IBptHospitalLegalDao bpthospitallegalDao) {
		this.bpthospitallegalDao = bpthospitallegalDao;
	}

	public void updateBptHospitalLegal(BptHospitalLegal bptHospitalLegal){
		bpthospitallegalDao.update(bptHospitalLegal);
	}
	public void insertBptHospitalLegal(BptHospitalLegal bptHospitalLegal){
		bpthospitallegalDao.insert(bptHospitalLegal);
	}
	public void saveBptHospitalLegal(List<BptHospitalLegal> list) {
		if (list != null && !list.isEmpty()) {
			this.bpthospitallegalDao.save(list);
		}
	}
	public DataSet queryBptHospitalLegal(ParameterSet pset) {
		return bpthospitallegalDao.query(pset);
	}
	public void saveBptHospitalLegalList(BptHospital bpthospital, List<BptHospitalLegal> line) {
		List bpthospitalList = new ArrayList();
		bpthospitalList.add(bpthospital);
		this.bpthospitalDao.save(bpthospitalList);
		if (line != null && !line.isEmpty()) {
			this.bpthospitallegalDao.save(line);
		}
	}
	

	public void delete(List<String> list) {
//		IBptHospitalDetailDao bpthospitalDetailDao = (IBptHospitalDetailDao) DaoFactory
//        .getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptHospitalDetailDao");

		
		try {
			bpthospitalDetailDao = new BptHospitalDetailDao();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String[] bpthospitalIds = list.toArray(new String[list.size()]);
		List<String> hlist = new ArrayList<String>();//获取bpthospitalDetailId 准备删除法人
		ParameterSet pset= new ParameterSet();
		for(int i = 0 ;i<bpthospitalIds.length;i++){
			pset.setParameter("HOSPITAL_ID", bpthospitalIds[i]);
			DataSet ds = bpthospitalDetailDao.query(pset);
			for(int j=0 ;j<ds.getCount();j++){
				hlist.add((String)ds.getRecord(j).get("id"));
			}
		}
		String[] bpthospitalDetailIds = hlist.toArray(new String[hlist.size()]);
			bpthospitalDetailDao.batchDeleteByBptHospital(bpthospitalIds);
			bpthospitallegalDao.batchDeleteByBptHospitalDetail(bpthospitalDetailIds);
			bpthospitalDao.batchDeleteByBptHospital(bpthospitalIds);
	}
	//删除详细信息
	public void hospitalDelete(String[] list) {
		try {
			bpthospitalDetailDao = new BptHospitalDetailDao();
		} catch (Exception e) {
			e.printStackTrace();
		}
		bpthospitalDetailDao.batchDeleteHospitalDetail(list);
		bpthospitallegalDao.batchDeleteByBptHospitalDetail(list);
	}
	public DataSet queryBptHospital(ParameterSet pset) {
		return bpthospitalDao.query(pset);
	}

	public DataSet queryBptHospitalDetail(ParameterSet pset){
		return  bpthospitalDetailDao.query(pset);
	}
	public DataSet getMaxYear(ParameterSet pset){

		try {
			bpthospitalDetailDao = new BptHospitalDetailDao();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return  bpthospitalDetailDao.getMaxYear(pset);
	}




}