package com.inspur.cams.prs.prsretiredsoldiers.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISoldiersuploadDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface ISoldiersuploadDao extends BaseCURD<SoldiersUpload>{
	public void save(List<SoldiersUpload> list);
}

