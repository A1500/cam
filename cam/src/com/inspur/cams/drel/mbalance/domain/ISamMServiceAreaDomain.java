package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.mbalance.data.SamMServiceArea;

/**
 * @author luguosui
 * 医院入院备案对象属地配置domain接口
 */
public interface ISamMServiceAreaDomain {
	
	public DataSet query(ParameterSet pset);
	
	public void insert(SamMServiceArea dataBean);
	
	public void save(List<SamMServiceArea> list);
	
	public void update(SamMServiceArea dataBean);
	
	public void delete(String[] delIds);
	
}
