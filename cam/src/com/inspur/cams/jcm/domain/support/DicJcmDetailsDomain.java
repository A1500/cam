package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IDicJcmDetailsDao;
import com.inspur.cams.jcm.data.DicJcmDetails;
import com.inspur.cams.jcm.domain.IDicJcmDetailsDomain;

/**
 * 字典详细信息domain
 * @author 
 * @date 2014-05-22
 */
public class DicJcmDetailsDomain implements IDicJcmDetailsDomain {

	@Reference
	private IDicJcmDetailsDao dicJcmDetailsDao;

	/**
	 * 查询 字典详细信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicJcmDetailsDao.query(pset);
	}

	/**
	 * 获取 字典详细信息
	 * @param pset
	 * @return
	 */
	public DicJcmDetails get(String code) {
		return dicJcmDetailsDao.get(code);
	}

	/**
	 * 增加 字典详细信息
	 * @param dicJcmDetails
	 */
	public void insert(DicJcmDetails dicJcmDetails) {
		dicJcmDetailsDao.insert(dicJcmDetails);
	}
	
	/**
	 * 修改 字典详细信息
	 * @param dicJcmDetails
	 */
	public void update(DicJcmDetails dicJcmDetails) {
		dicJcmDetailsDao.update(dicJcmDetails);
	}
	
	/**
	 * 删除 字典详细信息
	 * @param code
	 */
	public void delete(String code) {
		dicJcmDetailsDao.delete(code);
	}

	public void save(List equList) {
		dicJcmDetailsDao.save(equList);
	}

}