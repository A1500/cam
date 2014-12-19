package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPeopleTransferManage;


/**
 * 人员调动表domain
 * @author zhenSenSen 
 * @date 2014-12-15
 */
public interface IJcmPeopleTransferManageDomain {

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
	public JcmPeopleTransferManage get(String id);

	/**
	 * 增加 人员调动表
	 * @param JcmPeopleTransferManage
	 */
	@Trans
	public void insert(JcmPeopleTransferManage jcmPeopleTransferManage);
	
	/**
	 * 修改 人员调动表
	 * @param JcmPeopleTransferManage
	 */
	@Trans
	public void update(JcmPeopleTransferManage jcmPeopleTransferManage);
	
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