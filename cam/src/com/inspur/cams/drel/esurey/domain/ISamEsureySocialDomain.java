package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureySocial;


/**
 * @title:ISamEsureySocialDomain
 * @description:人力资源和社会保障domain接口
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public interface ISamEsureySocialDomain {

	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureySocial dataBean);

	public void insert(SamEsureySocial dataBean);

	public void save(List<SamEsureySocial> list);
	
	public void delete(String peopleId);
	@Trans
	public void getSamEsureySocial(SamEsureySocial[] Beans,String peopleId);
	
	public DataSet queryExtSocial(ParameterSet pset);
	
}
