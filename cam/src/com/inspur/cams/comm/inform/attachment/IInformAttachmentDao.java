package com.inspur.cams.comm.inform.attachment;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IInInformAttachmentDao
 * @description:
 * @author:
 * @since:2009-10-27
 * @version:1.0
*/
 public interface IInformAttachmentDao extends BaseCURD<InformAttachment>{
	public void save(List<InformAttachment> list);
}

