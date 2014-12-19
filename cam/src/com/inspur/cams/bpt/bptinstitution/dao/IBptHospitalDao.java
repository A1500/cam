package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptinstitution.data.BptHospital;


/**
 * @title:IBptHospitalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public interface IBptHospitalDao extends BaseCURD<BptHospital>{
	public void save(List<BptHospital> list);
	public void batchDeleteByBptHospital(String[] fkId);
}

