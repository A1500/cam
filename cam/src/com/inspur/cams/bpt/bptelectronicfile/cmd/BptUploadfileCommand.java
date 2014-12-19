package com.inspur.cams.bpt.bptelectronicfile.cmd;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao;
import com.inspur.cams.bpt.base.data.BptElectronic;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFile;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFileDao;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfile;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfileDao;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptUploadfileCommand
 * @description:
 * @author:
 * @since:2011-06-21
 * @version:1.0
 */
public class BptUploadfileCommand extends BaseAjaxCommand {
	private BptUploadfileDao dao = (BptUploadfileDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfileDao");
	private BptElectronicDao BptElectronicDao = (BptElectronicDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao");
	private BptElectronicFileDao bptElectronicFileDao = (BptElectronicFileDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicFileDao");
	private BptCatalogueArchivesDao bptCatalogueArchivesDao = (BptCatalogueArchivesDao) DaoFactory
			.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
	private static final String file_dir=CamsProperties.getString("file_dir");	
	
	/**
	 * 上传附件存数据库
	 * 
	 * 
	 */
	@Trans
	public void insert() {	
		Record record = (Record) getParameter("record");
		BptUploadfile dataBean = (BptUploadfile) record
				.toBean(BptUploadfile.class);
		String fileId = IdHelp.getUUID30();
		dataBean.setFileId(fileId);

		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 用于存放所有附件的名字
		List<String> filenames = new ArrayList<String>();
		List<String> prefilenames = new ArrayList<String>();
		String filename = null;

		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		while (iterator.hasNext()) {
			List<BptUploadfile> list = new ArrayList<BptUploadfile>();
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			// 如果文件名相同，则只保存第一条，其余的放弃。
			filename = uploadfile.getFileName();
			if (filenames.contains(filename)) {
				continue;
			}
			filenames.add(filename);
			prefilenames.add(filename);
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFiles(uploadfile);
			list.add(dataBean);
			// 保存通知附件
			dao.batchInsert(list);
		}
	}

	/**
	 * 上传附件存服务器本地
	 * 
	 * 
	 */
	@Trans
	public void uploadinsert() {

		BspUtil BspUtil = new BspUtil();
		String organCode = BspUtil.getOrganCode().substring(0, 6);

		DateUtil DateUtil = new DateUtil();
		String date = DateUtil.getDay();
		String fileId_edoc = "";
		String fileName_edoc = "";
		Record record = (Record) getParameter("record");
		BptUploadfile dataBean = (BptUploadfile) record
				.toBean(BptUploadfile.class);
		BptElectronic bptElectronic = (BptElectronic) record
				.toBean(BptElectronic.class);
		BptElectronicFile bptElectronicFile = (BptElectronicFile) record
				.toBean(BptElectronicFile.class);
		// String fileType = (String) record.get("fileType");
		String peopleId = (String) record.get("peopleId");
		String catalogCode = (String) record.get("catalogCode");
		String fileSave = (String) record.get("fileSave");
		String electronicId = (String) record.get("electronicId");
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;

		// 用于存放所有附件的名字
		List<String> filenames = new ArrayList<String>();
		List<String> prefilenames = new ArrayList<String>();
		String filename = null;

		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		while (iterator.hasNext()) {
			String fileId = IdHelp.getUUID30();
			fileId_edoc = fileId_edoc + fileId + ",";

			List<BptUploadfile> list = new ArrayList<BptUploadfile>();
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			// 定义文件保存位置
			String type = (uploadfile.getFileName()).substring(uploadfile
					.getFileName().indexOf("."));
			String fileFoder = file_dir + organCode;
			String Datename = fileFoder + "/" + date;
			String fileName = file_dir + organCode + "/" + date + "/"
					+ fileId + type;
			fileName_edoc = fileName_edoc + uploadfile.getFileName() + ",";
			// 写数据库表BptUploadfile
			filenames.add(filename);
			prefilenames.add(filename);
			dataBean.setFileId(fileId);
			dataBean.setFileType(fileId + type);
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFilePath(file_dir + organCode + "/" + date + "/");
			list.add(dataBean); // 保存通知附件
			dao.batchInsert(list);

			// 写数据库表bpt_ElectronicId_file
			bptElectronicFile.setElectronicId(electronicId);
			bptElectronicFile.setFileId(fileId);
			bptElectronicFileDao.insert(bptElectronicFile);

			// 新建上传文件夹
			File foder = new File(fileFoder);
			File datename = new File(Datename);
			// 如果文件夹不存在，则创建文件夹
			if (foder.exists() == false) {
				foder.mkdirs();// 多级目录
			}
			if (datename.exists() == false) {
				datename.mkdirs();
			}
			InputStream in = null;
			FileOutputStream outs = null;
			// 保存上传文件
			try {
				outs = new FileOutputStream(fileName);
				in = uploadfile.getInputStream();// 流文件
				int size = 0;
				byte[] buffer = new byte[8192];
				while ((size = in.read(buffer, 0, 8192)) != -1) {
					outs.write(buffer, 0, 8192);// 流的形式写
				}
				outs.close();
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if (in != null)
					try {
						in.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				if (outs != null)
					try {
						outs.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

			}

		}
		// 写数据库表电子档案库
		BptUploadfileCommand bptUploadfileCommand = new BptUploadfileCommand();
		DataSet ds = bptUploadfileCommand.ElectronicId(electronicId);
		Record Electronicrecord = ds.getRecord(0);

		Electronicrecord.set("peopleId", peopleId);
		if (fileId_edoc.length() > 1) {
			fileId_edoc = fileId_edoc.substring(0, fileId_edoc.length() - 1);
		}
		Electronicrecord.set("fileId", fileId_edoc);
		if (fileName_edoc.length() > 1) {
			fileName_edoc = fileName_edoc.substring(0,
					fileName_edoc.length() - 1);
		}
		Electronicrecord.set("fileName", fileName_edoc);
		Electronicrecord.set("fileSave", fileSave);
		Electronicrecord.set("filePath", file_dir + organCode + "/" + date
				+ "/");
		BptElectronic bptElectronicbean = (BptElectronic) Electronicrecord
				.toBean(BptElectronic.class);
		BptElectronicDao.update(bptElectronicbean);
	}

	/**
	 * 上传附件存服务器本地
	 * 
	 * 
	 */
	@Trans
	public void fileupload() {

		BspUtil BspUtil = new BspUtil();
		String organCode = BspUtil.getOrganCode().substring(0, 6);

		DateUtil DateUtil = new DateUtil();
		String date = DateUtil.getDay();
		String fileId_edoc = "";
		String fileName_edoc = "";
		String electronicId = (String) getParameter("electronicId");
		String fileContext = (String) getParameter("fileMess");
		String fileNameUp = (String) getParameter("fileName");
		String rangeFlag = (String) getParameter("rangeFlag");
		//System.out.println(fileContext);
		Record record = new Record();
		BptUploadfile dataBean = (BptUploadfile) record
				.toBean(BptUploadfile.class);
		BptElectronic bptElectronic = (BptElectronic) record
				.toBean(BptElectronic.class);
		BptElectronicFile bptElectronicFile = (BptElectronicFile) record
				.toBean(BptElectronicFile.class);
		//BptElectronicDao.get(arg0);
		int fileNum=bptElectronicFileDao.getFileNum(electronicId);
		String filename = "图片"+fileNum;
		String fileId = IdHelp.getUUID30();
		fileId_edoc = fileId_edoc + fileId + ",";
		// 根据file_type获得filename

		// fileName1,fileName2 “1.jgp”

		// 定义文件保存位置
		String type = fileNameUp.substring(fileNameUp.indexOf("."));
		String fileFoder = file_dir + organCode;
		String Datename = fileFoder + "/" + date;
		String filePath = file_dir + organCode + "/" + date + "/" + fileId
				+ type;
		fileName_edoc = filename + type;
		
		// 写数据库表BptUploadfile
		// filenames.add(filename);
		// prefilenames.add(filename);
		dataBean.setFileId(fileId);
		dataBean.setFileType(fileId + type);
		dataBean.setFileName(filename + type);
		dataBean.setFilePath(file_dir + organCode + "/" + date + "/");
		dataBean.setRangeFlag(rangeFlag);
		dataBean.setViewOrder(new BigDecimal(fileNum));
		
		// list.add(dataBean); // 保存通知附件
		dao.insert(dataBean);

		// 写数据库表bpt_ElectronicId_file
		bptElectronicFile.setElectronicId(electronicId);
		bptElectronicFile.setFileId(fileId);
		bptElectronicFileDao.insert(bptElectronicFile);

		// 新建上传文件夹
		File foder = new File(fileFoder);
		File datename = new File(Datename);
		// 如果文件夹不存在，则创建文件夹
		if (foder.exists() == false) {
			foder.mkdirs();// 多级目录
		}
		if (datename.exists() == false) {
			datename.mkdirs();
		}
		// 写文件
		createPicFormatBASE64(fileContext, filePath);
		// 写数据库表电子档案库
		BptUploadfileCommand bptUploadfileCommand = new BptUploadfileCommand();
		DataSet ds = bptUploadfileCommand.ElectronicId(electronicId);
		Record Electronicrecord = ds.getRecord(0);

		Electronicrecord.set("peopleId", Electronicrecord.get("peopleId"));
		/*if (fileId_edoc.length() > 1) {
			fileId_edoc = fileId_edoc.substring(0, fileId_edoc.length() - 1);
		}*/
		Electronicrecord.set("fileId", fileId);
		/*if (fileName_edoc.length() > 1) {
			fileName_edoc = fileName_edoc.substring(0,
					fileName_edoc.length() - 1);
		}*/
		Electronicrecord.set("fileName", filename + type);
		// Electronicrecord.set("fileSave",fileSave);
		Electronicrecord.set("filePath", file_dir + organCode + "/" + date+ "/");
		BptElectronic bptElectronicbean = (BptElectronic) Electronicrecord.toBean(BptElectronic.class);
		BptElectronicDao.update(bptElectronicbean);
	}
	@Trans
	private void createPicFormatBASE64(String str, String picPath) {
		try {
			byte[] result = new sun.misc.BASE64Decoder().decodeBuffer(str.trim());
			RandomAccessFile inOut = new RandomAccessFile(picPath, "rw"); // r,rw,rws,rwd
			// 用FileOutputStream亦可
			inOut.write(result);
			inOut.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据electronicId查询附件表bpt_electronic记录
	 * 
	 * @return
	 * 
	 * 
	 */
	public DataSet ElectronicId(String electronicId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ELECTRONIC_ID@=", electronicId);
		DataSet ds = BptElectronicDao.query(pset);
		return ds;
	}
/**
 * BptElectronicFileDao
 * @param electronicId
 * @return
 */
	public DataSet getElectronicFile(String electronicId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("FILE_ID@=", electronicId);
		DataSet ds = bptElectronicFileDao.query(pset);
		return ds;
	}
	/**
	 * 根据fileId查询filePath
	 * 
	 * @return
	 * 
	 * 
	 */
	public DataSet fileloadByid(String fileId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("FILE_ID@=", fileId);
		DataSet ds = dao.query(pset);
		return ds;
	}

	/**
	 * 用户的目录维护
	 * 
	 */
	@Trans
	public void personCatalogMaintain() {
		String peopleId = (String)getParameter("peopleId");
		String applyId =getParameter("applyId")==null?"":(String)getParameter("applyId");
		Record[] selectedRecords = (Record[]) getParameter("selected");
		
		BptElectronic bptElectronic = new BptElectronic();
		if(applyId.equals(""))//数据采集部分使用了此段代码，怕影响数据采集，没有修改此部分代码，数据采集的applyid is null
		{
			//添加新记录
			if(selectedRecords != null){
				for(int i=0;i<selectedRecords.length;i++){
					bptElectronic.setElectronicId(IdHelp.getUUID30());
					bptElectronic.setPeopleId(peopleId);
					bptElectronic.setServiceType(selectedRecords[i].get("serviceType").toString());
					bptElectronic.setFileType(selectedRecords[i].get("catalogCode").toString());
					bptElectronic.setFileName("");
					BptElectronicDao.insert(bptElectronic);
				}
			}
			//删除记录
			Record[] vbptElectronicRecords = (Record[]) getParameter("vbptElectronicRecords");
			if(vbptElectronicRecords != null){
				for(int i=0;i<vbptElectronicRecords.length;i++){
					ParameterSet pset = new ParameterSet();
					pset.setParameter("PEOPLE_ID", peopleId);		
					pset.setParameter("APPLY_ID@is", null);	
					pset.setParameter("SERVICE_TYPE", vbptElectronicRecords[i].get("serviceType").toString());
					pset.setParameter("FILE_TYPE", vbptElectronicRecords[i].get("catalogCode").toString());
					DataSet ds = BptElectronicDao.query(pset);
					String electronicId = ds.getRecord(0).get("electronicId").toString();
					BptElectronicDao.delete(electronicId);
				}
			}
		}else
		{
			//添加新记录
			if(selectedRecords != null){
				for(int i=0;i<selectedRecords.length;i++){
					bptElectronic.setElectronicId(IdHelp.getUUID30());
					bptElectronic.setPeopleId(peopleId);
					bptElectronic.setApplyId(applyId);
					bptElectronic.setServiceType(selectedRecords[i].get("serviceType").toString());
					bptElectronic.setFileType(selectedRecords[i].get("catalogCode").toString());
					bptElectronic.setFileName("");
					BptElectronicDao.insert(bptElectronic);
				}
			}
			//删除记录
			Record[] vbptElectronicRecords = (Record[]) getParameter("vbptElectronicRecords");
			if(vbptElectronicRecords != null){
				for(int i=0;i<vbptElectronicRecords.length;i++){
					ParameterSet pset = new ParameterSet();
					pset.setParameter("PEOPLE_ID", peopleId);		
					pset.setParameter("APPLY_ID", applyId);//测试是否影响数据采集
					pset.setParameter("SERVICE_TYPE", vbptElectronicRecords[i].get("serviceType").toString());
					pset.setParameter("FILE_TYPE", vbptElectronicRecords[i].get("catalogCode").toString());
					DataSet ds = BptElectronicDao.query(pset);
					String electronicId = ds.getRecord(0).get("electronicId").toString();
					BptElectronicDao.delete(electronicId);
				}
			}
		}
	}
	@Trans
	public void fileDelete() {

		String electronicId = (String) getParameter("electronicId");
		String fileId = (String) getParameter("fileId");
		String filePath="";
		String fileType="";
		Record record = new Record();
		BptUploadfile fileBean = (BptUploadfile) record.toBean(BptUploadfile.class);
		BptElectronic bptElectronic = (BptElectronic) record.toBean(BptElectronic.class);
		BptElectronicFile bptElectronicFile = (BptElectronicFile) record.toBean(BptElectronicFile.class);
		
		//获得文件存放地址：
		try
		{
		Record fileRecord =fileloadByid(fileId).getRecord(0);
		filePath=(String) fileRecord.get("filePath");
		fileType=(String) fileRecord.get("fileType");
		System.out.println("filePath="+filePath);
		
		//删除表：bpt_uploadfile，bpt_electronic_file		
		bptElectronicFileDao.deleteByeid_fid(electronicId,fileId);
		dao.delete(fileId);
		//删除文件：
		
			File file = new File(filePath+fileType);
			if (file.isFile() && file.exists()) {
				file.delete();
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}
	}
	@Trans
	public void save() {
		//Record record = (Record) getParameter("records");
		
		Record[] records = (Record[]) getParameter("records");
		Record record =records[0];
		BptUploadfile dataBean = (BptUploadfile) record.toBean(BptUploadfile.class);
		dao.update(dataBean);
	}

}
