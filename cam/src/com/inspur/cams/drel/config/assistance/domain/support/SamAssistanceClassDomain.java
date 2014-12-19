package com.inspur.cams.drel.config.assistance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.config.assistance.dao.ISamAssistanceClassDao;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;
import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceClassDomain;

/**
 * @title:分类施保配置domain
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
public class SamAssistanceClassDomain implements ISamAssistanceClassDomain {
	@Reference
	private ISamAssistanceClassDao samAssistanceClassDao;
	/**
	 * 查询分类施保配置
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return samAssistanceClassDao.query(pset);
	}
	
	/**
	 * 根据主键查询分类施保配置
	 * @param assistanceClassId
	 * @return
	 */
	public SamAssistanceClass get(String assistanceClassId){
		return samAssistanceClassDao.get(assistanceClassId);
	}
	
	/**
	 * 增加分类施保配置
	 * @param samAssistanceClass
	 */
	@Trans
	public void insert(SamAssistanceClass samAssistanceClass){
		samAssistanceClassDao.insert(samAssistanceClass);
	}
	
	/**
	 * 更新分类施保配置
	 * @param samAssistanceClass
	 */
	@Trans
	public void update(SamAssistanceClass samAssistanceClass){
		samAssistanceClassDao.update(samAssistanceClass);
	}
	
	/**
	 * 删除分类施保配置
	 * @param assistanceClassId
	 */
	@Trans
	public void delete(String assistanceClassId){
		samAssistanceClassDao.delete(assistanceClassId);
	}

	public SamAssistanceClass getClassMoney(ParameterSet pset) {
		return samAssistanceClassDao.getClassMoney(pset);
		
	}
}