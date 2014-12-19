package com.inspur.cams.comm.dicm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.dao.IDicDetailsDao;
import com.inspur.cams.comm.dicm.data.DicDetails;
import com.inspur.cams.comm.dicm.domain.IDicDetailsDomain;

public class DicDetailsDomain implements IDicDetailsDomain {
	
	@Reference
	private IDicDetailsDao dicDetailsDao;
	
	public void insert(DicDetails dicDetails) {
		dicDetailsDao.insert(dicDetails);
	}

	public DataSet query(ParameterSet pset) {
		return dicDetailsDao.query(pset);
	}

	public void save(List<DicDetails> list) {
		dicDetailsDao.save(list);
	}

	public void update(DicDetails dicDetails) {
		dicDetailsDao.update(dicDetails);
	}

	/**
	 * 页面显示字典表时调用查询方法
	 * @param pset
	 * @return
	 */
	public DataSet queryForDic(ParameterSet pset){
		return dicDetailsDao.queryForDic(pset);
	}

	/**
	 * 页面显示字典表时调用查询方法（通用）
	 * @param pset
	 * @return
	 */
	public DataSet queryForGeneralDic(ParameterSet pset){
		return dicDetailsDao.queryForGeneralDic(pset);
		
	}
}
