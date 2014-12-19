package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;
/**
 * @description:添加和查询残疾情况介绍信的Domain层接口
 * @author 王宝才
 * @since:2011-05-18
 */
public interface IDisabilityIdentificationDomain{
	/**
	 * 添加残疾情况介绍信
	 */
	public void insert(DisabilityIdentification disabilityIdentification);
	
	/**
	 * 更新残疾情况介绍信
	 */
	public void update(DisabilityIdentification disabilityIdentification);
	
	/**
	 * 查询残疾情况介绍信
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 获得编号最后三位的最大值
	 */
	 public String getMaxNumber(String idPre);
	
}