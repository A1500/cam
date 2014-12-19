package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyCarDomain
 * @description:公安domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyCar;

public interface ISamEsureyCarDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyCar dataBean);

	public void insert(SamEsureyCar dataBean);

	public void save(List<SamEsureyCar> list);
	
	public void delete(String peopleId);
	/*
	 * 车辆信息
	 */
	public void getSamEsureyCar(SamEsureyCar[] Beans,String peopleId);
	
	public DataSet queryExtCar(ParameterSet pset);
}
