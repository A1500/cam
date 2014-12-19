package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmDic;


/**
 * 人员调动表domain
 * @author zhenSenSen 
 * @date 2014-12-15
 */
public interface IJcmDicDomain {

	/**
	 * 查询 人员调动表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员调动表
	 * @param pset
	 * @return
	 */
	public JcmDic get(String id);

	/**
	 * 增加 人员调动表
	 * @param jcmDic
	 */
	@Trans
	public void insert(JcmDic jcmDic);
	
	/**
	 * 修改 人员调动表
	 * @param jcmDic
	 */
	@Trans
	public void update(JcmDic jcmDic);
	
	/**
	 * 删除 人员调动表
	 * @param id
	 */
	@Trans
	public void delete(String id);
	/**
	 * 保存 人员调动表
	 * @param list
	 */
	@Trans
	public void save(List equList);
}