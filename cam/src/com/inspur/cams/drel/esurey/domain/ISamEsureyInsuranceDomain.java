package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyInsuranceDomain
 * @description:保监domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;

public interface ISamEsureyInsuranceDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyInsurance dataBean);

	public void insert(SamEsureyInsurance dataBean);

	public void save(List<SamEsureyInsurance> list);
	
	public void delete(String peopleId);
	/*
	 * 保监信息
	 */
	public void getEsureyInsurance(SamEsureyInsurance[] Beans,String peopleId);
	
	public DataSet queryExtInsurance(ParameterSet pset);
}
