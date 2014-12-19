package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IDicCompanyMoneyTypeDao;
import com.inspur.cams.jcm.data.DicCompanyMoneyType;
import com.inspur.cams.jcm.domain.IDicCompanyMoneyTypeDomain;

/**
 * 单位经费类别domain
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyMoneyTypeDomain implements IDicCompanyMoneyTypeDomain {

	@Reference
	private IDicCompanyMoneyTypeDao dicCompanyMoneyTypeDao;

	/**
	 * 查询 单位经费类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCompanyMoneyTypeDao.query(pset);
	}

	/**
	 * 获取 单位经费类别
	 * @param pset
	 * @return
	 */
	public DicCompanyMoneyType get(String code) {
		return dicCompanyMoneyTypeDao.get(code);
	}

	/**
	 * 增加 单位经费类别
	 * @param dicCompanyMoneyType
	 */
	public void insert(DicCompanyMoneyType dicCompanyMoneyType) {
		dicCompanyMoneyTypeDao.insert(dicCompanyMoneyType);
	}
	
	/**
	 * 修改 单位经费类别
	 * @param dicCompanyMoneyType
	 */
	public void update(DicCompanyMoneyType dicCompanyMoneyType) {
		dicCompanyMoneyTypeDao.update(dicCompanyMoneyType);
	}
	
	/**
	 * 删除 单位经费类别
	 * @param code
	 */
	public void delete(String code) {
		dicCompanyMoneyTypeDao.delete(code);
	}

}