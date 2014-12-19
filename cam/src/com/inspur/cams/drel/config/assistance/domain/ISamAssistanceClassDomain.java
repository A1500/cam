package com.inspur.cams.drel.config.assistance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;


/**
 * @title:分类施保配置domain接口
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
public interface ISamAssistanceClassDomain {
	/**
	 * 查询分类施保配置
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 根据主键查询分类施保配置
	 * @param assistanceClassId
	 * @return
	 */
	public SamAssistanceClass get(String assistanceClassId);

	/**
	 * 增加分类施保配置
	 * @param samAssistanceClass
	 */
	@Trans
	public void insert(SamAssistanceClass samAssistanceClass);
	
	/**
	 * 更新分类施保配置
	 * @param samAssistanceClass
	 */
	@Trans
	public void update(SamAssistanceClass samAssistanceClass);
	
	/**
	 * 删除分类施保配置
	 * @param assistanceClassId
	 */
	@Trans
	public void delete(String assistanceClassId);
	/**
	 * 根据分类施保类别回填分类施保金
	 * @return
	 */
	public SamAssistanceClass getClassMoney(ParameterSet pset);
}