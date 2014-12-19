package com.inspur.sdmz.comFamilyOrgan.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IComFamilyOrganDao
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 public interface IComFamilyOrganDao extends BaseCURD<ComFamilyOrgan>{
	public void save(List<ComFamilyOrgan> list);
}

