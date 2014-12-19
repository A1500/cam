package com.inspur.cams.prs.prsTrainDic.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IDicPrsTrainFieldDao
 * @description:
 * @author:
 * @since:2012-09-21
 * @version:1.0
*/
 public interface IDicPrsTrainFieldDao extends BaseCURD<DicPrsTrainField>{
	public void save(List<DicPrsTrainField> list);
}

