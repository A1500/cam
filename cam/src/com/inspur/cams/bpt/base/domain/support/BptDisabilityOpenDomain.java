package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptDisabilityOpenDao;
import com.inspur.cams.bpt.base.data.BptDisabilityOpen;
import com.inspur.cams.bpt.base.domain.IBptDisabilityOpenDomain;

public class BptDisabilityOpenDomain implements IBptDisabilityOpenDomain {
	@Reference
	private IBptDisabilityOpenDao bptDisabilityOpenDao;
	
	public DataSet queryDisabilityOpen(ParameterSet pset) {
		return bptDisabilityOpenDao.query(pset);
	}

	public void updateOpen(BptDisabilityOpen bptDisabilityOpen) {
		
		bptDisabilityOpenDao.update(bptDisabilityOpen);
	}
	
	
	public void saveOpen(BptDisabilityOpen bptDisabilityOpen) {
		bptDisabilityOpenDao.insert(bptDisabilityOpen);
	}

}
