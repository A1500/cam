package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.DicJcmDetails;

/**
 * 字典详细信息domain
 * @author 
 * @date 2014-05-22
 */
public interface IDicJcmDetailsDomain {

	/**
	 * 查询 字典详细信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 字典详细信息
	 * @param pset
	 * @return
	 */
	public DicJcmDetails get(String code);

	/**
	 * 增加 字典详细信息
	 * @param dicJcmDetails
	 */
	@Trans
	public void insert(DicJcmDetails dicJcmDetails);
	
	/**
	 * 修改 字典详细信息
	 * @param dicJcmDetails
	 */
	@Trans
	public void update(DicJcmDetails dicJcmDetails);
	
	/**
	 * 删除 字典详细信息
	 * @param code
	 */
	@Trans
	public void delete(String code);
	@Trans
	public void save(List equList);
}