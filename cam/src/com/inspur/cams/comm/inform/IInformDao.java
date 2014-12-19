package com.inspur.cams.comm.inform;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IInInformDao
 * @description:
 * @author:
 * @since:2009-10-27
 * @version:1.0
*/
 public interface IInformDao extends BaseCURD<Inform>{
	public void save(List<Inform> list);
}

