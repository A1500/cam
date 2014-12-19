package com.inspur.cams.drel.mbalance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;

/**
 * @title:ISamMedicalBeforeDao
 * @description:
 * @author:
 * @since:2011-06-25
 * @version:1.0
*/
 public interface ISamMedicalBeforeDao extends BaseCURD<SamMedicalBefore>{
	public void save(List<SamMedicalBefore> list);
}

