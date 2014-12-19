package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;

/**
 * @title: IFisCemeItemsDao
 * @description:公墓审批事项dao接口
 * @author:lidongdong(xxz)
 * @since:2011-11-11
 * @version:1.0
 */
public interface IFisCemeItemsDao extends BaseCURD<FisCemeItems> {
	public void save(List<FisCemeItems> list);
}
