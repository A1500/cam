package com.inspur.sdmz.jtxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;


/**
 * @title:ISamFamilyAssistanceDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface ISamFamilyAssistanceDao extends BaseCURD<SamFamilyAssistance>{
		public void bathchDeleteByFamilyId(String[] familyId);
		public void deleteByFamilyId(String familyId);
}

