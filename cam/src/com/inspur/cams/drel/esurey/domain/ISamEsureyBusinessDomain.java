package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyBusinessDomain
 * @description:工商domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;

public interface ISamEsureyBusinessDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyBusiness dataBean);

	public void insert(SamEsureyBusiness dataBean);

	public void save(List<SamEsureyBusiness> list);
	
	public void delete(String peopleId);
	/*
	 * 工商信息
	 */
	public void getSamEsureyBusiness(SamEsureyBusiness[] Beans,String peopleId);
	
	public DataSet queryExtBusiness(ParameterSet pset);
}
