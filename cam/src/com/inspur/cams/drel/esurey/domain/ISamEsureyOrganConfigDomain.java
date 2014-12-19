package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;

public interface ISamEsureyOrganConfigDomain {
	
	public DataSet query(ParameterSet pst);
	@Trans
	public void save(List<SamEsureyOrganConfig> list);

}
