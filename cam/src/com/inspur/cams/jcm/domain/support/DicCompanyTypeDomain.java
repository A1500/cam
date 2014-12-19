package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IDicCompanyMoneyTypeDao;
import com.inspur.cams.jcm.dao.IDicCompanyTypeDao;
import com.inspur.cams.jcm.dao.IDicOfficeEquipmentTypeDao;
import com.inspur.cams.jcm.data.DicCompanyType;
import com.inspur.cams.jcm.domain.IDicCompanyTypeDomain;

/**
 * 单位所属类别domain
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyTypeDomain implements IDicCompanyTypeDomain {

	@Reference
	private IDicCompanyTypeDao dicCompanyTypeDao;
	
	@Reference
	private IDicOfficeEquipmentTypeDao dicOfficeEquipmentTypeDao;
	
	@Reference
	private IDicCompanyMoneyTypeDao dicCompanyMoneyTypeDao;

	/**
	 * 查询 单位所属类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCompanyTypeDao.query(pset);
	}

	/**
	 * 获取 单位所属类别
	 * @param pset
	 * @return
	 */
	public DicCompanyType get(String code) {
		return dicCompanyTypeDao.get(code);
	}

	/**
	 * 增加 单位所属类别
	 * @param dicCompanyType
	 */
	public void insert(DicCompanyType dicCompanyType) {
		dicCompanyTypeDao.insert(dicCompanyType);
	}
	
	/**
	 * 修改 单位所属类别
	 * @param dicCompanyType
	 */
	public void update(DicCompanyType dicCompanyType) {
		dicCompanyTypeDao.update(dicCompanyType);
	}
	
	/**
	 * 删除 单位所属类别
	 * @param code
	 */
	public void delete(String code) {
		dicCompanyTypeDao.delete(code);
	}
	
	
	/**
	 * 保存 字典
	 * @param code
	 */
	@Trans
	public void save(List equList,List comList,List monList){
		
		dicCompanyTypeDao.save(comList);
		dicOfficeEquipmentTypeDao.save(equList);
		dicCompanyMoneyTypeDao.save(monList);
		
	}

}